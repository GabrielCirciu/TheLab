# Conventions

### Asset and Resource naming conventions

**General rule**: CATEGORY_Subject_Descriptor_Variant

- Example: ENT_Player_Idle_01.anim

**Category is up to discussion for omission if project is small enough. For a small game we might not want category at all.**

Category examples:

- ENT - entities, player, monsters, npcs, things that move, creatures
- ENV - environment, things that don’t move, world, props
- We can make it more granular depending on scale (refactor might cost a lot of time if we decide later on)

***Always use 0 padding for variant numbers!***

**Models**: Subject_Component_Variant

- Example: Player_Head_Transformed

**Materials**: Subject_Material

- Example: Wood_Damp

**Textures**: Subject_Texture_Suffix

- Example: Player_Shirt_Color

Suffixes: Color, Normal, Roughness, Metallic, AO, Emission, Mask

We can discuss if certain suffixes are to be named something else (i.e. Diffuse instead of Color)

**Animations**: Subject_Action_Variant

- Example: Player_Walk_Left

**Audio**: Subject_Action_Variant

- Example: Player_Sit_01

**Shaders**: Name_Variant

- Example: Water_Bloody

**UI**: UI_Name_Action

- Example: UI_Button_Hover

**Resources**: Subject_DataType

- Example: Player_Data

### Code Naming conventions

|  | Convention | Example |
| --- | --- | --- |
| Classes/Nodes/Types | PascalCase | PlayerController |
| Functions/Methods | snake_case | calculate_damage() |
| Public properties | PascalCase | CurrentHealth |
| Private fields | _camelCase | _someCalculation |
| Local variables | camelCase | currentHealth |
| Paramateres | camelCase | damageAmount |
| Constants | UPPER_SNAKE_CASE | MAX_HEALTH |
| Enums | PascalCase | AnimationState |
| Enum values | PascalCase | Walking |
| Interfaces | I + PascalCase | IDamageable |
| Boolean | is/has/can/should + PascalCase | isGrounded |
| Events/Signals | past tense PascalCase | HealthChanged |

### Folder organization

Asset oriented as it is not too small to dump all files (e.g. textures) into a folder, and allows for scaling up.

Full folder organization found in  →

[Game Directory Structure](https://app.notion.com/p/Game-Directory-Structure-3e605b0d852a80a381a9d23077c092b0?pvs=21)

### Branching/merging strategies

No direct pushes to main. PRs are required. One extra reviewer required, I don’t care if they just tell you “Yeah whatever I don’t care. Approved.”, it’s now both of your faults if things don’t work 🙂. Don’t spend too much time on approval, a new asset like a chair model needs almost no extra review, and can be approved within 2 minutes.

**Discussion of who approves which PRs.**

**Branches:**

| Branch | Purpose | Lifetime |
| --- | --- | --- |
| main | Protected, always playable game is here | Permanent |
| feature | New functionality | < 1 week |
| fix | Bug fixes | < 1 day |
| refactor | Structural or code changes | < 1 week |
| art | Asset work | ~? Days |
| release | Near final release if needed by the end of our project | TBD |

Merging: Squash merge. Essentially rawdog all commits into 1 giga kraken commit and send it.

- Example: commit 1, commit 2, fix 1, fix 2 → feat: add player crouch

This allows for clean history on main branch

**MAKE SURE MAIN IS UP TO DATE BEFORE YOU DO A PR (PULL AND RESOLVE CONFLICT)**

**ALWAYS RESOLVE CONFLICTS YOURSELF**

**NEVER REBASE EACH OTHERS BRANCHES UNLESS THEY REQUEST IT**

When doing a PR, please do a short description on what it is that you are requesting to merge. (e.g. feature/player-crouching would just have “This implements the code that allows crouching, with crouching animation, camera movement, and slower player move speed”). Short and to the point 🙂

### Git commit conventions

Lightweight conventional commits with prefixes:

| Prefix | Purpose | Example |
| --- | --- | --- |
| feat | New feature implemented | feat: add player crouch code |
| asset | New asset (model/texture/audio/etc.) added | asset: add player crouch animation |
| fix | Bug got fixed | fix: prevent camera getting stuck in walls |
| refactor | Code and/or files refactored | refactor: extract health system |
| docs | Documenting work (in code or in a file) | docs: save system |
| chore | Annoying thing done (e.g. changed 1 value) | chore: update crouch camera position |

**DON’T COMMIT FULL PLAYABLE BUILDS, WE CAN UPLOAD THOSE SEPARATELY ON GITHUB UNDER RELEASES SECTION**

**I will see if I can implement an automated CI pipeline to build game at every merge on main to have the latest playebale version at all times automatically compiled.**

Thanks to AI, binary files can be merged, no clue how it works though, but can look into it. (i.e. Godot Scenes (equivalent to Unity Prefabs) are binary files, and it will get ugly to merge if two people are working on it at the same time)

**Milestone tracking with Git Tags.** We can use a more interesting tagging than just v0.1, the idea is:

- p01, p02, etc. → Prototype versions
- vs01, vs02, etc. → Vertical slice versions
- a01, b01, etc. → Alpha and/or beta versions
- r01, r02, etc. → Release versions

**For GitHub releases, we can use regular versioning (v0.1.0), as long as we agree which version counts as what, otherwise we can discuss to just use the same versioning for tags or vice-versa throughout for easy of use.**

### Git workflow

1. Pull latest main
2. Create a branch: feature/asset/etc. (e.g. feature/player-crouch)
3. Work locally
4. Make local commits: feat/fix/docs/etc. (e.g. fix: player crouch camera position)
5. Push branch
6. Open pull request
7. One teammate reviews it
8. Resolve review comments (if needed)
9. Update branch from main (ensure being latest before merging)
10. Squash merge into main
11. Delete branch
12. Pull latest main branch and start next task

### Code comment and documentation expectations

Everything should be self-explaining.

Function naming like `secret_calculation(a: int, b: char) → Void` are not advised.

Comment things that are not obvious like `velocity += deltaTime * 0.8` why 0.8, comment on that. Even better if you set a descriptive variable for what 0.8 is, like `_relativeGravity = 0.8` and then `velocity += deltatime * _relativeGravity`

Comment things that can’t be self explanatory in purpose like `if jumpBuffer > 0.1 and is_wet()` , what is going on with that? Why are we checking that? Comment those things. 

Document public APIs. If we have a `func apply_damage(amount: int) -> bool` you could comment what it does so we can look it up if we want to use it, and why it would return a `bool` (e.g. returns true if it can verify that damage has been applied). You can also document requirements and limitations, such as amount having to be positive, and where it’s expected to be called.

Avoid commenting out old code. We can track history if we need it with Git, let’s keep code tidy and readable.

If you want to document how a specific mechanic or system works, what interactions happen within code/assets, use the **Docs** folder and add a .md (markdown) file there. Depending on how many of these we get, we will organize it later. We can do a lot with markdown files, far more than just baisc text, that’s why I advise that.

### TODOs, and how to keep track

We can use GitHub Issues, alongside code comments with `TODO` in there to track. Some IDEs/Editors can highlight TODOs in code comments.

All TODOs have to be explained, so if someone else joins in to help you code, they know what is expected to be done without having to ask you. (i.e. don’t do `# TODO: fix this`, instead do `# TODO: crouching input only changes animation but not camera angle, ensure camera is also moved` , that is much easier to go from).

### Issues, errors, bugs

GitHub Issues and GitHub Project. Everything will be there.

Submit an Issue and the more you describe it the better, we can then figure out who gets to resolve it, how important it is, and other details. Not template recommendation as it might be too much work for the small game.

I promise you we will have a list of these by the end of the semester that we won’t be able to fix, and that is okay. Don’t stress about it.

Builds from main branch must be playable even if it has bugs. This way we will always have something to submit.