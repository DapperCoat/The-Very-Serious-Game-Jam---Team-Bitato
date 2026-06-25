class_name BaseUpgradeStrategy
extends Node

# to be displayed by UI
@export var upgrade_title: String = "base upgrade text"

# Acts as base for all ball upgrades
# does nothing by default
func apply_upgrade(ball: Ball):
	pass
