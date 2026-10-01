shader_type spatial;
render_mode cull_disabled, unshaded, depth_test_disabled;

// No source_color on these: depth is not a color, and the screen texture is already linear.
uniform sampler2D depth_texture : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// 0 = normal output
// 1 = raw depth (0 = near, 1 = far)
// 2 = linear distance, black = near, white = debug_range or more
// 3 = fog mask (white = fully fogged)
uniform int debug_mode : hint_range(0, 3) = 0;
uniform float debug_range : hint_range(1, 6000) = 50.0;

uniform bool enable_fog = true;
uniform vec3 fog_color : source_color = vec3(0.6, 0.7, 0.8);
uniform vec3 noise_color : source_color = vec3(0.4, 0.5, 0.6);
uniform float fog_distance : hint_range(1, 6000) = 25.0;
uniform float fog_fade_range : hint_range(1, 6000) = 15.0;
uniform bool enable_noise = true;
uniform float noise_time_fac : hint_range(0.1, 10) = 4.0; // noise updates per second
uniform bool enable_color_limitation = true;
uniform int color_levels : hint_range(2, 256) = 8;
uniform bool enable_dithering = true;
uniform float dither_strength : hint_range(0.0, 1.0) = 1.0;

// Per-pixel random value in 0..1, changes in steps over time.
float hash12(vec2 p) {
	float t = floor(TIME * noise_time_fac);
	p += vec2(t * 17.13, t * 31.71);
	return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

vec3 quantize_color(vec3 color, int levels) {
	float q = float(levels - 1);
	return floor(color * q + 0.5) / q;
}

// 4x4 Bayer matrix, returns 0..1
float bayer4(vec2 pos) {
	int x = int(mod(pos.x, 4.0));
	int y = int(mod(pos.y, 4.0));
	float m[16] = float[](
		0.0,    0.5,    0.125,  0.625,
		0.75,   0.25,   0.875,  0.375,
		0.1875, 0.6875, 0.0625, 0.5625,
		0.9375, 0.4375, 1.0,    0.8125
	);
	return m[x + y * 4];
}

void vertex() {
	// Full-screen quad (QuadMesh 2x2). z = 0.0 is safely inside the
	// Compatibility renderer's -1..1 clip range.
	POSITION = vec4(VERTEX.xy, 0.0, 1.0);
}

void fragment() {
	vec3 screen_color = texture(screen_texture, SCREEN_UV).rgb;
	float depth = texture(depth_texture, SCREEN_UV).x;

	// Compatibility renderer: depth is 0..1, NDC needs -1..1 on all axes.
	vec3 ndc = vec3(SCREEN_UV, depth) * 2.0 - 1.0;
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	view.xyz /= view.w;
	float linear_depth = -view.z;

	// 0 = no fog, 1 = fully fogged
	float fog_amount = clamp((linear_depth - (fog_distance - fog_fade_range)) / fog_fade_range, 0.0, 1.0);

	if (debug_mode == 1) {
		ALBEDO = vec3(depth);
	} else if (debug_mode == 2) {
		ALBEDO = vec3(clamp(linear_depth / debug_range, 0.0, 1.0));
	} else if (debug_mode == 3) {
		ALBEDO = vec3(fog_amount);
	} else {
		vec3 final_color = screen_color;

		if (enable_fog) {
			// Pick the fog layer's color first (flat or noisy), then blend it in once.
			vec3 far_color = fog_color;
			if (enable_noise) {
				far_color = mix(fog_color, noise_color, hash12(FRAGCOORD.xy));
			}
			final_color = mix(final_color, far_color, fog_amount);
		}

		// Dither BEFORE quantizing, as an offset of up to one quantization step.
		if (enable_dithering) {
			float step_size = 1.0 / float(max(color_levels - 1, 1));
			final_color += (bayer4(FRAGCOORD.xy) - 0.5) * step_size * dither_strength;
		}

		if (enable_color_limitation) {
			final_color = quantize_color(final_color, color_levels);
		}

		ALBEDO = clamp(final_color, 0.0, 1.0);
	}
}
