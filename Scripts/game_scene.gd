extends Node2D

@export var chip_manager: Node
@export var bet_manager: Control
@onready var house_score: Label = $UI/ChipsToBeatLabel
@onready var player_score: Label = $UI/PlayerChips
@onready var balls_left: Label = $UI/BallsLeft
@onready var place_your_bet: Label = $UI/PlaceYourBet
@onready var won_text: Label = $UI/BetWon
@onready var lost_text: Label = $UI/BetLost
@onready var roulette_wheel = $Roulette
# Basically lives for the roulette
var balls: int = 5

var wheel_colours = {
	0: "green",
	1: "red",
	2: "black",
	3: "red",
	4: "black",
	5: "red",
	6: "black",
	7: "red",
	8: "black",
	9: "red",
	10: "black",
	11: "red",
	12: "black",
	13: "red",
	14: "black",
	15: "red",
	16: "green",
	}

var wheel_values = [0,13,4,10,8,15,5,12,1,7,16,3,9,14,2,6,11]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_scores(false)
	# set wheel_can_spin to false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Set's wheel_can_spin to true & give wheel the bet_type
func _on_bet_manager_send_bet_info(bet_type: String, bet: int) -> void:
	_update_scores(true)
	
	roulette_wheel.spin()
	await get_tree().create_timer(1).timeout
	roulette_wheel.stop()
	await roulette_wheel.stopped
	var index = roulette_wheel.get_pocket()
	var value = wheel_values[index]
	var colour = wheel_colours[value]	
	print(bet_type)
	
	match bet_type:
		"black":
			if colour == bet_type:
				chip_manager.update_chips(true, 2.0)
				_bet_won()
			else:
				_bet_lost()
		"red":
			if colour == bet_type:
				chip_manager.update_chips(true, 2.0)
				_bet_won()
			else:
				_bet_lost()
		"green":
			if colour == bet_type:
				chip_manager.update_chips(true, 5.0)
				_bet_won()
				balls += 1
		"odd":
			if (value % 2 == 1):
				chip_manager.update_chips(true, 2.0)
				_bet_won()
			else:
				_bet_lost()
		"even":
			if (value % 2 == 0):
				chip_manager.update_chips(true, 2.0)
				_bet_won()
			else:
				_bet_lost()
	_update_scores(false)

func _update_scores(is_start: bool) -> void:
	# End Game if player chips == 0
	# Start new round if player chips >= chips to beat
	if is_start:
		balls -= 1
	elif chip_manager.player_chips >= chip_manager.chips_to_beat:
		chip_manager.raise_chips_to_beat()
		bet_manager.bet_state_clear()
		balls = 5
	elif chip_manager.player_chips == 0 or balls == 0:
		lost_text.text = "No Chips!"
		won_text.visible = false
		place_your_bet.visible = false
		lost_text.visible = true
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Scenes/intro.tscn")
		
	else: 
		bet_manager.bet_state_clear()
	
	house_score.text = "House: %3d" % [chip_manager.chips_to_beat]
	player_score.text = "Player: %3d" % [chip_manager.player_chips]
	balls_left.text = "Balls Left: " + str(balls)

func _bet_won() -> void:
	place_your_bet.visible = false
	won_text.visible = true
	await get_tree().create_timer(2).timeout
	won_text.visible = false
	place_your_bet.visible = true

func _bet_lost() -> void:
	place_your_bet.visible = false
	lost_text.visible = true
	await get_tree().create_timer(2).timeout
	lost_text.visible = false
	place_your_bet.visible = true
