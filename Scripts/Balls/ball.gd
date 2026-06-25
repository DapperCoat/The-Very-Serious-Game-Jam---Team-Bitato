class_name Ball
extends Area2D

# Stores base ball speed
var speed_multi: float = 1.0
# Stores base ball score multiplier
var score_multi: float = 1.0
# What slots trigger a better score multi (Odd/Even/Red/Black)
var slot_multi: Array[String] = []
# How many times it takes a ball to break down for a round
var ball_lives: int = 3
# How many balls the roulette wheel should have
var ball_count: int = 1
# Stores any upgrades
var upgrades: Array[BaseUpgradeStrategy] = []

# Function for applying upgrades
func apply_upgrades():
	for upgrade in upgrades:
		upgrade.apply_upgrade(self)
