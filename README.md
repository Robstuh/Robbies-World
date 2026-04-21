# 2D RPG Template (Godot)

## Overview
This repo contains a clean 2D RPG template for Godot 4 with:
- `autoloads/EventBus.gd` and `autoloads/GameState.gd`
- `entities/Actor.gd`, `entities/Player.gd`, `entities/Enemy.gd`
- core scenes: `scenes/Main.tscn`, `scenes/CombatArena.tscn`, `scenes/Player.tscn`, `scenes/Enemy.tscn`

## Setup
1. Open project in Godot 4.
2. In Project Settings -> AutoLoad:
   - Add `autoloads/EventBus.gd` as `EventBus`
   - Add `autoloads/GameState.gd` as `GameState`
   - Add `autoloads/QuestSystem.gd` as `QuestSystem`
   - Add `autoloads/Inventory.gd` as `Inventory`
3. Set `scenes/Main.tscn` as the main scene.
4. Add input actions (`Input Map`): `move_up`, `move_down`, `move_left`, `move_right`.
5. Add action `ui_accept` for dialogue advance (Enter/Space).

## Running
- Launch from `Main.tscn`.
- Player movement via WASD/arrows.
- Colliding with an enemy triggers a combat scene transition.

## Next tasks
- Add `TileSet` + tilemap world tiles
- Implement turn-based combat logic in `CombatArena` (implemented)
- Add NPC interaction and dialogue UI (basic implemented)
- Add inventory (implemented), quests (basic implemented), save/load
- Add leveling system (implemented)

