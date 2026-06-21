class_name Wheel extends Node2D

@onready var sprite: Sprite2D = get_node("Sprite2D")

@export var num_segments: int = 34
@export var outer_radius: float = 6400.0
@export var inner_radius: float = 0.0

@export var ang_speed: float = 12 
@export var stop_decay: float = 0.98
 
enum STATES {IDLE, SPINNING, STOPPING}
var state = STATES.IDLE

signal stopped
	
# Spin the wheel
func spin(speed=15):
	ang_speed = speed
	state = STATES.SPINNING
	
# Stop the wheel
func stop():
	state = STATES.STOPPING
	
# Check if a position is on the wheel and returns segment	
func get_segment(global_pos: Vector2) -> int:
	var local = to_local(global_pos)

	var r = local.length()

	if r < inner_radius:
		return -1

	if r > outer_radius:
		return -1

	var angle = local.angle() - rotation

	angle = fposmod(angle, TAU)

	var segment_angle = TAU / num_segments

	return int(angle / segment_angle)
	
func _process(_delta: float) -> void:
	if state == STATES.IDLE:
		return
	
	rotation += ang_speed * _delta
	match state:
		
		STATES.SPINNING:
			pass
		
		STATES.STOPPING:
			ang_speed *= pow(stop_decay, _delta * 60.0)
			if ang_speed < 0.1:
				ang_speed = 0
				state = STATES.IDLE
				stopped.emit()
