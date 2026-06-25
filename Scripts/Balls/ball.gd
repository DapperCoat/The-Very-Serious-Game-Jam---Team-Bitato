class_name Ball
extends Area2D

@onready var upgrade_cont: Node = $UpgradeCont
var possible_upgrades: Array[BaseUpgradeStrategy] = []
# Stores base ball speed
var speed_multi: float = 1.0
# Stores ball score multiplier for when landing on certain slots
var score_multi: float = 1.75
# What slots trigger a better score multi (Odd/Even/Red/Black)
var slot_multi: Array[String] = []
# How many times it takes a ball to break down for a round
var max_ball_lives: int = 3
# How many lives a ball has left this
var current_ball_lives: int = max_ball_lives
# How many balls the roulette wheel should have
var ball_count: int = 1
# Flavor Text of Upgrades
var upgrade_text: Array[String] = []

# Selects random upgrade from UpgradeContainer
func select_random_upgrade() -> void:
	var possible_upgrades: Array[BaseUpgradeStrategy] = []
	for child in upgrade_cont:
		possible_upgrades.append(child)
	_apply_upgrade(possible_upgrades.pick_random())

# Function for applying upgrades
func _apply_upgrade(upgrade) -> void:
	upgrade.apply_upgrade(self)
