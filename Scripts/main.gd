extends Node

@onready var wheel = get_node("Wheel")
@onready var spin_button = get_node("UI/SpinButton")
@onready var ball = get_node("Wheel/Ball")

func _on_spin_button_pressed() -> void:
	#wheel.spin()
	#await get_tree().create_timer(1).timeout
	#wheel.stop()
	#await wheel.stopped
	var winning_segment = wheel.get_pocket(ball.global_position)
	print(winning_segment)
