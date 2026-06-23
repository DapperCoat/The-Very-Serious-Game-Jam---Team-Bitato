class_name Ball extends Node2D


@export var orbit_radius := 500.0
@export var ang_speed := 12.0

var angle := 0.0

enum STATES {IDLE, STOPPING}
var state = STATES.IDLE

signal stopped

func _process(delta):
	match state:
		STATES.IDLE:
			pass
			
		STATES.STOPPING:	
			angle += ang_speed * delta 

			position = Vector2(
				cos(angle),
				sin(angle)
			) * orbit_radius
			
			ang_speed *= 0.99
			if ang_speed < 0.05:
				ang_speed = 0
				state = STATES.IDLE
				stopped.emit()
