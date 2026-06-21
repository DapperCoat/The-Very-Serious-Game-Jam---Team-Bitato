extends Node

# amount chips_to_beat gets multiplied by 
const CHIP_MULTI: float = 1.35
# Amount of chips player has
var player_chips: int = 10
# Chip number to match or beat
var chips_to_beat: int
# chips bet
var chips_bet: int

func place_bet(bet: int) -> void:
	chips_bet = bet
	player_chips -= bet

# called by outside script when bet state is gotten after spin
func update_chips(bet_won: bool, multi = CHIP_MULTI) -> void:
	if bet_won:
		player_chips += round(chips_bet * multi)
	else:
		chips_bet = 0

# Raises chips_to_beat based on chip multi and how ever many extra chips the player had over chips_to_beat
func raise_chips_to_beat() -> void:
	chips_to_beat = round(chips_to_beat * CHIP_MULTI) + (player_chips - chips_to_beat)
