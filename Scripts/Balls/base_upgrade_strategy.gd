class_name BaseUpgradeStrategy
extends Resource

@export var upgrade_title: String

# Acts as base for all ball upgrades
# does nothing by default
func apply_upgrade(ball: Ball):
	pass
