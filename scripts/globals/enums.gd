extends Node
# Global

enum PassiveType {
	PRE_ATTACK,
	PRE_DEFENSE,
	POST_ATTACK,
	POST_DEFENSE,
}

enum EffectTargeting {
	SELF,
	OPPONENT,
}

enum StatusEffect {
	POISON,
	BURN,
	BLEED,
	BLIND,
	STUN,
}