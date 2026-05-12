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
- `state_data.gd` — shared mutable data passed between all states

All battle states (units array, turn index, active effects, etc.) live in `BattleStateData`, not on individual state nodes. States are stateless transition handlers.

### Resource vs. Runtime Split

Content is split into two layers:
- **Resources** (`scripts/resources/`): Godot `Resource` subclasses defining templates — Unit stats/abilities, Passive blueprints, Special blueprints, Effect definitions, AI personalities. Authored in the editor, serialized to `.tres` files in `resources/`.
- **Runtimes** (`scripts/runtimes/`): In-memory instances created from Resources at battle start — track current HP/MP, active status effects, etc.

Follow this pattern when implementing any new game entity.

### Effect System

All abilities use a polymorphic `apply(source, target)` interface defined in `effect_run.gd`. The base class handles targeting logic (SELF / OPPONENT / BOTH from `Constants.EffectTargeting`); subclasses implement `_apply(source, target) -> bool`. `EffectRun.from_resource(res)` is the factory — it dispatches to the correct runtime subclass based on the resource type.

Effect subclasses: `DMGRun`, `BurnRun`, `BleedRun`, `PoisonRun`, `LifeStealRun`.

### AI System

Enemy units are assigned a random `AIRes` personality at runtime (`scripts/resources/ai_res.gd`). Fields: `attack_percent`, `act_on_first_turn`, `first_turn_is_special`, `special_near_death`. AI logic lives in `ActionInput` state.

### Console (Debug Utility)

`console.gd` is an autoload singleton (`Console`) providing text I/O for testing before visual UI exists. Commands are lines starting with `/`. Use it throughout battle state implementations to surface game events.

## Battle System Design

The full battle system is specified in `docs/design/battle/logic/`. Implementation follows this state sequence:

```
Battle Start → Turn Start Burn → Action Input → Special/Attack → Turn End Bleed → Turn End Poison → Battle End
```

Key design docs:
- `units/0010 - Stats.md` — HP, MP, ATK, DEF, SPD; all integers, clamped 0–base
- `units/0011 - Passives.md`, `0012 - Specials.md`, `0013 - Status Effects.md`, `0014 - Loot.md`, `0035 - AI.md`
- `states/0015–0026` — one file per battle state, specifies exact logic
- `effects/0025` — all abilities use a standard `apply(source, target)` interface

Design docs are the source of truth for game logic — read them before implementing a state or ability.

## Conventions

- Class names: `PascalCase` (match file name, e.g. `StateMachine` in `state_machine.gd`)
- Methods and variables: `snake_case`
- State classes go in `scripts/scenes/battle/battle_states/`, resource classes in `scripts/resources/`, runtime classes in `scripts/runtimes/`
- Spelling: American English (e.g. "channeled", not "channelled")

## Current Status

In progress (Milestone 0003 — Battle, target July 4 2026). Implemented: state machine framework, Console autoload, full Resource/Runtime split, all 8 battle states, effect system, passive/special system, AI system, Player + Wolf + Snake units. Remaining: loot system, additional units (dragon + more animals), missing AI personalities (cautious, mischievous), Stun/Blind status effects, visual UI (planned Milestone 0006).

Roadmap: `docs/milestones/` contains numbered milestone files (0003–0009) with full scope per phase.