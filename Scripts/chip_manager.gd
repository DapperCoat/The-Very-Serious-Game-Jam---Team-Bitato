extends Node

# amount chips_to_beat gets multiplied by 
const CHIP_MULTI: float = 1.35
# Amount of chips player has
var player_chips: int = 10
# Chip number to match or beat
var chips_to_beat: int = 15
# chips bet
var chips_bet: int = 0

func set_bet(bet: int) -> void:
	if bet <= player_chips:
		chips_bet = bet
		player_chips -= bet
	else:
		print("bet is too large")

# called by outside script when bet state is gotten after spin
func update_chips(bet_won: bool, multi: float) -> void:
	if bet_won:
		player_chips += round(chips_bet * multi * CHIP_MULTI)
	else:
		chips_bet = 0

# Raises chips_to_beat based on chip multi and how ever many extra chips the player had over chips_to_beat
func raise_chips_to_beat() -> void:
	chips_to_beat = round(chips_to_beat * CHIP_MULTI) + (player_chips - chips_to_beat)
