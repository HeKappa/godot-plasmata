extends Area2D

signal encounter

export(Resource) var trainer setget set_trainer
export(bool) var passive

func set_trainer(value) -> void:
	trainer = value
	$sprite.call_deferred("create_instance", true, trainer.world_graphic)

func _on_area_entered(area):
	if not passive:
		set_deferred("monitoring", false)
		emit_signal("encounter")

func _input(event) -> void:
	if not monitoring:
		return

	if Input.is_action_just_pressed("ui_accept"):
		var player = find_parent("level").find_node("player")
		if overlaps_area(player):
			set_deferred("monitoring", false)
			emit_signal("encounter")