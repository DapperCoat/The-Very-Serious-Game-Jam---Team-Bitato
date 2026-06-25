extends Node2D

@export var chip_manager: Node
@export var bet_manager: Control
@onready var house_score: Label = $UI/ChipsToBeatLabel
@onready var player_score: Label = $UI/PlayerChips

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_scores()
	# set wheel_can_spin to false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Set's wheel_can_spin to true & give wheel the bet_type
func _on_bet_manager_send_bet_info(bet_type: String, bet: int) -> void:
	_update_scores()

# Needs signal from wheel to know if game was win or lose 
# func _to_be(did_bet_win):
# bet_manager.bet_state_clear()

func _update_scores() -> void:
	house_score.text = "House: %3d" % [chip_manager.chips_to_beat]
	player_score.text = "Player: %3d" % [chip_manager.player_chips]
