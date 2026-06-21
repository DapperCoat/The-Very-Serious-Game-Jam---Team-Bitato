extends Node2D

@onready var sprite: Sprite2D = get_node("Sprite2D")
@export var num_segments: int = 32
@export var ang_speed: float = 12 

enum STATES {IDLE, SPINNING, STOPPING}
var state = STATES.IDLE

func _ready() -> void:
	spin()
	await get_tree().create_timer(1).timeout
	stop()
	
# Spin the wheel
func spin(speed=12):
	ang_speed = speed
	state = STATES.SPINNING
	
# Stop the wheel
func stop():
	state = STATES.STOPPING
	
# Check if a position is on the wheel and returns segment
func check_position(pos):
	pass
	
func _process(_delta: float) -> void:
	rotation += ang_speed * _delta
	match state:
		STATES.IDLE:
			pass
		
		STATES.SPINNING:
			pass
		
		STATES.STOPPING:
			ang_speed *= 0.95
			if ang_speed <= 0:
				state = STATES.IDLE
