extends Node

@onready var wheel = get_node("Wheel")
@onready var spin_button = get_node("UI/SpinButton")
@onready var ball = get_node("Wheel/Ball")

func _on_spin_button_pressed() -> void:
	wheel.spin()
	await get_tree().create_timer(1).timeout
	wheel.stop()
	await wheel.stopped
	var winning_segment = wheel.get_pocket(ball.global_position)
	var pockets = [25,17,34,6,27,13,36,11,30,8,23,5,24,16,1,20,14,31,9,22,18,29,7,28,12,35,3,26,0,32,15,19,4,21,2]
	print(pockets[winning_segment])
