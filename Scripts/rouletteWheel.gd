extends Node2D

# REMEMBER, spinActive SHOULD ONLY BE TRUE WHEN THE PLAYER CAN SPIN THE WHEEL!!
var spinActive := true ## To allow the system to know when the player should be allowed to drag the wheel
var flyActive := false ## To allow the system to know when the wheel should start spinning on its own
var hasSpinBeenActivated := false ## bug fixing reasons
var mouseInArea: bool ## Detects whether mouse is in or our of the roulette's radius
@onready var grabTimer := $"Mouse Grab Time Limit" ## so that if you change anything about the timer node, it's easier to change without changing every reference to it
@onready var sprite := $"Placeholder Sprite"## so that if you change anything about the sprite node, it's easier to change without changing every reference to it
var outOfTime: bool  ## if you run out of time to drag the wheel
var firstClick := true ## is this the first click or not
var initialMousePos: Vector2 ## get the first mouse pos on click to find the wheel angle
var maxSpinTime := 0.5  ## the max amount of time you can spin the wheel
var spinSpeedMultiplier := 0.07 ## the speed which the wheel spin will be multiplied by
var power: float ## this is so when it needs to go flying, it uses the angle for power
var initialPowerMultiplier := 1.7 ## just to give the spin an extra boost to make it feel better
var flyDecay := 0.985 ## To know how fast it should stop spinning
var flyExponential := 0.994 ## To make it slowdown exponentially 

func _ready():
	grabTimer.wait_time = maxSpinTime


func _process(delta):
	
	
	# ok, so we're going to track the mouse pos while it's in the area raidus
	# the wheel will spin with the mouse from it's original position
	# then when it leaves, we find the arc distance
	# and use that for spin power
	# this is about to be the least efficent code you've ever seen
	if spinActive: # if you can spin
		
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouseInArea: # if the player is holding the mouse down, and in the area
			hasSpinBeenActivated = true
			if !outOfTime: # if there is time left to drag
				if firstClick == true: # if you just put the mouse down (to get inital pos)
					firstClick = false
					initialMousePos = get_local_mouse_position()
				power = initialMousePos.angle_to(get_local_mouse_position()) * spinSpeedMultiplier
				sprite.rotation += power
				# theoretically, it should auto end the spinning if angle is PI/2, 
				# but that's just unlikely with the shape of the donut, 
				# so I won't bother accounting for it, and hope it doesn't bite me in the ass
				
			else: # when the time limit runs out
				spinActive = false
				flyActive = true
				power *= initialPowerMultiplier
				
			if grabTimer.time_left == 0: # if the timer isn't going, start it
				grabTimer.start()
				outOfTime = false 
		
		else: # if no longer clicking or in area
			if hasSpinBeenActivated: # only if it started to spin
				spinActive = false
				flyActive = true
				hasSpinBeenActivated = false
				power *= initialPowerMultiplier
			grabTimer.stop() # end the timer to not cause issues
			
	else: # if you can't spin (to fix a couple things)
		firstClick = true # to reset it for the next time
		
	
	if flyActive:
		sprite.rotation += power * flyDecay
		flyDecay *= flyExponential
		# obvious glaring bug I forgot to deal with last night
		# it needs to unactivate this variable when the speed gets low enough
		if power*flyDecay < 0.001: 
			flyActive = false
	
func _on_wheel_area_mouse_entered():
	mouseInArea = true

func _on_wheel_area_mouse_exited():
	mouseInArea = false

func _on_mouse_grab_time_limit_timeout():
	outOfTime = true
