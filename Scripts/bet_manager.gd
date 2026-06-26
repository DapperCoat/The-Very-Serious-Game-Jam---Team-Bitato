extends Control
# Reference to chip_manager 
@export var chip_manager: Node
@export var roulette_wheel: Node2D
@onready var bet_display = $LabelCont/BetDisplay
@onready var button_cont = $ButtonCont
# String is just a placeholder, will have to see how it interacts with wheel & other systems
var bet_state: String = "none"
var potential_bet: int = 0

# Sends bet info to wheel
signal send_bet_info(bet_type: String, bet: int)

# States control what bet the player placed
# State clear meant to be called by outside script after roulette
func bet_state_clear() -> void:
	#chip_manager.place_bet(0) 
	bet_display.text = str(0)
	_set_button_disable(false, "none")

#used for quickly changing if buttons are enabled the bet state
func _set_button_disable(is_disabled: bool, new_bet_state: String) -> void:
	bet_state = new_bet_state
	for child in button_cont.get_children():
		child.disabled = is_disabled
		if child.button_pressed:
			child.button_pressed = false

# Buttons for selecting type of bet
# Even Select 
func _on_even_select_pressed() -> void:
	chip_manager.set_bet(potential_bet)
	if potential_bet != 0:
		print("even bet placed for " + str(potential_bet))
		_set_button_disable(true, "even")
		send_bet_info.emit(bet_state, potential_bet)

# Red Select
func _on_red_select_pressed() -> void:
	chip_manager.set_bet(potential_bet)
	if potential_bet != 0:
		print("red bet placed for " + str(potential_bet))
		_set_button_disable(true, "red")
		send_bet_info.emit(bet_state, potential_bet)

# Black Select
func _on_black_select_pressed() -> void:
	chip_manager.set_bet(potential_bet)
	if potential_bet != 0:
		print("black bet placed for" + str(potential_bet))
		_set_button_disable(true, "black")
		send_bet_info.emit(bet_state, potential_bet)

# Odd Select
func _on_odd_select_pressed() -> void:
	chip_manager.set_bet(potential_bet)
	if potential_bet != 0:
		print("odd bet placed for " + str(potential_bet))
		_set_button_disable(true, "odd")
		send_bet_info.emit(bet_state, potential_bet)

# removes from potential bet
func _on_minus_button_pressed() -> void:
	if (potential_bet - 1) < 0:
		print("Cannot go below 0")
	else:
		potential_bet -= 1
		bet_display.text = str(potential_bet)
		

# adds to potential bet
func _on_plus_button_pressed() -> void:
	#chip_manager.player_chips
	if (potential_bet + 1) > chip_manager.player_chips:
		print("cannot bet above available chips")
	else:
		potential_bet += 1
		bet_display.text = str(potential_bet)
