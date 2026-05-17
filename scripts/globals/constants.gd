extends Node
# Global

enum PassiveType {
	PRE_ATTACK,
	PRE_DEFENSE,
	POST_ATTACK,
	POST_DEFENSE,
	TURN_START_SELF,
	BATTLE_START_SELF,
}

enum EffectTargeting {
	SELF,
	OPPONENT,
}

enum StatType {
	HP,
	MP,
	ATK,
	DEF,
	SPD
}

enum StatusEffect {
	POISON,
	BURN,
	BLEED,
	BLIND,
	STUN,
}

enum LootType {
	NO_CHANGE,
	STATIC,
	RANDOM,
}

const VOWELS = ["a", "e", "i", "o", "u"]
