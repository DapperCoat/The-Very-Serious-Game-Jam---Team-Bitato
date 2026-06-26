extends Node2D

@onready var wheel: Sprite2D = get_node("Wheel")

@export_category("Wheel")
@export var num_segments: int = 16
@export var outer_radius: float = 180.0
@export var inner_radius: float = 140.0

var ang_speed: float
@export var stop_decay: float = 0.98

@export_category("Ball")
@onready var ball: Sprite2D = get_node("Ball")
@export var orbit_radius := 180.0
var ball_ang_speed = ang_speed
var ball_angle := 0.0

enum STATES {IDLE, SPINNING, STOPPING}
var state = STATES.IDLE

signal stopped
	
# Spin the wheel
func spin(speed=18.0):
	ang_speed = speed
	state = STATES.SPINNING
	ball_ang_speed = ang_speed
	
# Stop the wheel
func stop():
	state = STATES.STOPPING
	
# Check if a position is on the wheel and returns pocket	
func get_pocket(global_pos: Vector2 = ball.position) -> int:
	var local = to_local(global_pos)
	
	var segment_angle = TAU / num_segments
	var angle = local.angle() 
	
	angle = fposmod(angle, TAU) 

	return int(angle / segment_angle)
	
func _process(_delta: float) -> void:
	if state == STATES.IDLE:
		return
	
	rotation += ang_speed * _delta
	match state:
		
		STATES.SPINNING:
			if ball_ang_speed > 3 and orbit_radius < outer_radius:
				orbit_radius *= 1.05
		
		STATES.STOPPING:
			# Wheel movement
			ang_speed *= pow(stop_decay, _delta * 60.0)
			
			if ang_speed < 0.05:
				ang_speed = 0
				
			# Ball movement
			ball_angle += (ball_ang_speed - ang_speed) * _delta 
			
			ball.position = Vector2(
				cos(ball_angle),
				sin(ball_angle)
			) * orbit_radius
			
			ball_ang_speed *= 0.99
			
			if ball_ang_speed < 3 and orbit_radius > inner_radius:
				orbit_radius *= 0.995
				
			if ball_ang_speed < 0.1:
				ball_ang_speed = 0
				state = STATES.IDLE
				stopped.emit()
