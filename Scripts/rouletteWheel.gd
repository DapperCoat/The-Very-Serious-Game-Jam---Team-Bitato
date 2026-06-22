extends Node2D


# placeholder to see if the function works
func _process(delta):
	if wheelSpinActive and Input.is_action_just_pressed("ui_accept"):
		wheelSpin()


# ok, so we're going to track the mouse pos while it's in the area raidus
# the wheel will spin with the mouse from it's original position
# then when it leaves, we find the arc distance
# and use that for spin power
# this is about to be the least efficent code you've ever seen
var mouseInArea: bool ## Detects whether mouse is in or our of the roulette's radius
var outOfTime : bool ## if you run out of time to drag the wheel
@export var sprite := Node2D ## to make it easier to change the sprite nodes without fucking up the code
var wheelSpinActive := true ## placeholder variable
var counter: int
func wheelSpin():
	wheelSpinActive = false
	outOfTime = false
	$"Mouse Grab Time Limit".start()
	var initialMouseX = get_local_mouse_position().x
	var initialMouseY = get_local_mouse_position().y
	counter = 0 
	while mouseInArea and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT): #and not outOfTime:
		# we're doing math now. cool. love math
		# my calculus exam is tomorrow and I'm doing this instead
		# ok watch this
		# we do the dot product with components
		# and then undo it with vectors
		# and get the angle
		# this took like an hour to figure out
		var firstLine = sqrt(initialMouseX**2 + initialMouseY**2) ## this is the line between the origin and the initial mouse pos
		var currentLine = sqrt(get_local_mouse_position().x**2 + get_local_mouse_position().y**2) ## this is the line between the current mouse pos and the origin
		# firstLine*currentLine*cos(theta) = initialMouseX*get_local_mouse_position().x + initialMouseY*get_local_mouse_position().y
		# cos(theta) = (initialMouseX*get_local_mouse_position().x + initialMouseY*get_local_mouse_position().y) / firstLine*currentLine
		var theta = acos((initialMouseX*get_local_mouse_position().x + initialMouseY*get_local_mouse_position().y) / firstLine*currentLine)
		if get_local_mouse_position().x != 0 and get_local_mouse_position().y != 0:
			sprite.rotation += theta
		# the following code is to make sure it stops crashing during testing
		counter += 1
		if counter > 50000:
			print(theta)
			break
	wheelSpinActive = true
	
func _on_wheel_area_mouse_entered():
	mouseInArea = true

func _on_wheel_area_mouse_exited():
	mouseInArea = false

func _on_mouse_grab_time_limit_timeout():
	outOfTime = true
