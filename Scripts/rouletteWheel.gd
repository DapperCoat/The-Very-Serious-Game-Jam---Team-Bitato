extends Node2D


# placeholder to see if the function works
func _process(delta):
	if wheelSpinActive and Input.is_action_just_pressed("ui_accept"):
		wheelSpin()

# ok, so we're going to track the mouse pos while it's in the area raidus
# the wheel will spin with the mouse from it's original position
# then when it leaves, we find the arc distance
# and use that for spin power
var mouseInArea: bool ## Detects whether mouse is in or our of the roulette's radius
var wheelSpinActive := true ## placeholder variable
var counter ## placeholder variable
func wheelSpin():
	wheelSpinActive = false
	counter = 0
	while mouseInArea and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		
		# everthing here is so it just stops crashing in testing
		print(counter)
		counter += 1
		if counter > 500:
			break
	wheelSpinActive = true

func _on_wheel_area_mouse_entered():
	mouseInArea = true

func _on_wheel_area_mouse_exited():
	mouseInArea = false
