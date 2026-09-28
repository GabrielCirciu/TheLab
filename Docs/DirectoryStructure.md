# Game Directory Structure Example
```
GAME
│
├── Entities
│   ├── Player
│   │   ├── Prefab(s)
│   │   ├── Mesh(s)
│   │   ├── Material(s)
│   │   ├── Texture(s)
│   │   ├── Animation(s)
│   │   ├── Shader(s)
│   │   ├── Movement Script
│   │   ├── Interaction Script
│   │   └── Interaction Script(s)
│   │
│   ├── Monsters
│   │   ├── Zombie
│   │   │   ├── Prefab(s)
│   │   │   ├── Mesh(s)
│   │   │   ├── Material(s)
│   │   │   ├── Texture(s)
│   │   │   ├── Animation(s)
│   │   │   └── Shader(s)
│   │   └── Crawler
│   │         ├── Prefab(s)
│   │         ├── Mesh(s)
│   │         ├── Material(s)
│   │         ├── Texture(s)
│   │         ├── Animation(s)
│   │         └── Shader(s)
│   │
│   └── NPCs
│   │   ├── Doctor
│   │   │   ├── Prefab(s)
│   │   │   ├── Mesh(s)
│   │   │   ├── Material(s)
│   │   │   ├── Texture(s)
│   │   │   ├── Animation(s)
│   │   │   └── Shader(s)
│   │   └── Officer
│   │         ├── Prefab(s)
│   │         ├── Mesh(s)
│   │         ├── Material(s)
│   │         ├── Texture(s)
│   │         ├── Animation(s)
│   │         └── Shader(s)
│   │
│   └── Entity Assets
│         ├── Materials
│         ├── Textures
│         └── Shaders
│
├── World
│   ├── Environments
│   │   ├── Bedroom
│   │   │   ├── Prefab(s)
│   │   │   ├── Mesh(s)
│   │   │   ├── Material(s)
│   │   │   ├── Texture(s)
│   │   │   ├── Animation(s)
│   │   │   └── Shader(s)
│   │   └── Bathroom
│   │         ├── Prefab(s)
│   │         ├── Mesh(s)
│   │         ├── Material(s)
│   │         ├── Texture(s)
│   │         ├── Animation(s)
│   │         └── Shader(s)
│   │
│   ├── Props
│   │   ├── Table
│   │   │   ├── Prefab(s)
│   │   │   ├── Mesh(s)
│   │   │   ├── Material(s)
│   │   │   ├── Texture(s)
│   │   │   ├── Animation(s)
│   │   │   └── Shader(s)
│   │   └── Chair
│   │         ├── Prefab(s)
│   │         ├── Mesh(s)
│   │         ├── Material(s)
│   │         ├── Texture(s)
│   │         ├── Animation(s)
│   │         └── Shader(s)
│   │
│   ├── Interactables
│   │   ├── Door
│   │   │   ├── Prefab(s)
│   │   │   ├── Mesh(s)
│   │   │   ├── Material(s)
│   │   │   ├── Texture(s)
│   │   │   ├── Animation(s)
│   │   │   └── Shader(s)
│   │   └── Computer
│   │         ├── Prefab(s)
│   │         ├── Mesh(s)
│   │         ├── Material(s)
│   │         ├── Texture(s)
│   │         ├── Animation(s)
│   │         └── Shader(s)
│   │
│   ├── Items
│   │   ├── Syringe
│   │   │   ├── Prefab(s)
│   │   │   ├── Mesh(s)
│   │   │   ├── Material(s)
│   │   │   ├── Texture(s)
│   │   │   ├── Animation(s)
│   │   │   └── Shader(s)
│   │   └── Flamethrower
│   │         ├── Prefab(s)
│   │         ├── Mesh(s)
│   │         ├── Material(s)
│   │         ├── Texture(s)
│   │         ├── Animation(s)
│   │         └── Shader(s)
│   │
│   ├── Triggers
│   │   ├── Door Interaction Field 1
│   │   └── Ladder Climb Field 1
│   │
│   └── World Assets
│         ├── Material(s)
│         ├── Texture(s)
│         └── Shader(s)
│
├── Global Assets
│   ├── Material(s)
│   ├── Texture(s)
│   └── Shader(s)
│
├── Resources
│   ├── Player Stats “table”
│   ├── Monster(s) Stats “table”
│   └── Game State “table”
│
├── Systems
│   ├── Event Script(s)
│   ├── Procedural Generation Script(s)
│   └── Save Script
│
├── Scenes
│   ├── Main Menu
│   ├── Game
│   └── Ending(s)
│
├── Audio
│   ├── Music
│   │   └── Song(s)
│   ├── Ambient
│   │   └── Ambience(s)
│   ├── SFX
│   │   └── Effect(s)
│   └── Audio Tool or Management Script(s)
│
├── UI
│   ├── HUD
│   │   └── Texture(s)
│   ├── Inventory
│   │   └── Texture(s)
│   ├── Interaction Script(s)
│   └── Menu Template(s)
│
├── Tools
│   └── Debug Script(s)
│
└── Docs
      ├── Build Instruction(s)
      ├── Technical Decisions
      │   └── ADR-001-Engine
      └── Design Decisions
            └── DDR-001-Theme
