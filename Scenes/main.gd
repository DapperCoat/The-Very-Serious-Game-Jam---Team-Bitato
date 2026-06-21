extends Node

@onready var wheel: Wheel = $Wheel
@onready var spin_button = $UI/SpinButton
@onready var ball = $Ball

func _on_spin_button_pressed() -> void:
	wheel.spin()
	await get_tree().create_timer(1).timeout
	wheel.stop()
	await wheel.stopped
	var winning_segment = wheel.get_segment(ball.global_position)
	print(winning_segment)
