extends EffectRun
class_name StunRun

func init(_res: StunRes) -> void:
	pass

func _apply(_source: UnitRun, target: UnitRun) -> bool:
	var res: bool = false

	if not target.is_alive: return res

	if not target.resists_stun:
		# Can't stun an already stunned unit
		if not target.is_stunned:
			target.is_stunned = true
			Console.print_line("* [%s] became Stunned" % [target])
			res = true
	else:
		Console.print_line("* [%s] resists Stun" % target)

	return res
