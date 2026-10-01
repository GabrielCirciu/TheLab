shader_type spatial;
render_mode unshaded, cull_front;

uniform vec4 outline_color : source_color = vec4(1.0, 0.85, 0.2, 1.0);
uniform float outline_width = 3.0;
// Turn this on for hard-edged meshes (cubes, buttons) whose origin is near their center.
uniform bool use_position_as_normal = false;

void vertex() {
	vec3 n = use_position_as_normal ? normalize(VERTEX) : NORMAL;
	vec4 clip = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
	vec3 view_normal = normalize(MODELVIEW_NORMAL_MATRIX * n);
	vec2 clip_normal = (mat3(PROJECTION_MATRIX) * view_normal).xy;
	clip.xy += normalize(clip_normal) * (outline_width * 2.0 / VIEWPORT_SIZE) * clip.w;
	POSITION = clip;
}

void fragment() {
	ALBEDO = outline_color.rgb;
}