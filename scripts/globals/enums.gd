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
	BOTH,
}

enum Immunity {
	POISON,
	BURN,
	BLEED,
	BLIND,
	STUN,
}