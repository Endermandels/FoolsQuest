# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

**Run the project:**
```
godot --path . scenes/battle.tscn
```

**Run headless (for testing logic):**
```
godot --headless --path . scenes/battle.tscn
```

Godot has no separate build or lint step. Type errors surface at runtime or via the Godot editor's built-in script editor.

## Architecture

### State Machine (Core Pattern)

Battle flow is controlled entirely by a generic state machine in `scripts/components/`:

- `state_machine.gd` — manages the current state, owns `StateData`, calls `step()` each frame
- `state.gd` — base class; subclass and override `enter(data)`, `step(data) -> State`, `exit(data)`
- `state_data.gd` — shared mutable data passed between all states; currently empty, will hold battle runtime state

All battle states (units array, turn index, active effects, etc.) live in `StateData`, not on individual state nodes. States are stateless transition handlers.

### Resource vs. Runtime Split (Planned Pattern)

Content is split into two layers:
- **Resources** (`resources/`): Godot `Resource` subclasses defining templates — Unit stats/abilities/loot, Passive blueprints, Special blueprints, Effect definitions. These are authored in the editor.
- **Runtime**: In-memory instances created from Resources at battle start — track current HP/MP, active status effects, etc.

Follow this pattern when implementing any new game entity.

### Console (Debug Utility)

`console.gd` is an autoload singleton (`Console`) providing text I/O for testing before visual UI exists. Commands are lines starting with `/`. Use it throughout battle state implementations to surface game events.

## Battle System Design

The full battle system is specified in `docs/design/battle/logic/`. Implementation follows this state sequence:

```
Battle Start → Turn Start Burn → Action Input → Special/Attack → Turn End Bleed → Turn End Poison → Battle End
```

Key design docs:
- `units/0010 - Stats.md` — HP, MP, ATK, DEF, SPD; all integers, clamped 0–base
- `units/0011 - Passives.md`, `0012 - Specials.md`, `0013 - Status Effects.md`, `0014 - Loot.md`
- `states/0015–0026` — one file per battle state, specifies exact logic
- `effects/0025` — all abilities use a standard `apply(source, target)` interface

## Conventions

- Class names: `PascalCase` (match file name, e.g. `StateMachine` in `state_machine.gd`)
- Methods and variables: `snake_case`
- State classes go in `scripts/battle/states/`, resource classes in `scripts/battle/resources/`
- Design docs are the source of truth for game logic — read them before implementing a state or ability

## Current Status

Implemented: state machine framework, Console autoload, project structure.

In progress (Milestone 0003 — Battle, target July 4 2026): Unit Resource/Runtime classes, all battle states, 8 animal opponents + 2-stage dragon boss, balance pass.

Roadmap: `docs/milestones/` contains numbered milestone files (0003–0009) with full scope per phase.
