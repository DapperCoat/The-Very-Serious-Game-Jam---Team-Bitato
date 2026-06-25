extends BaseUpgradeStrategy

func apply_upgrade(ball: Ball):
	ball.slot_multi.append("odd")
	ball.upgrade_text.append(upgrade_title)
	queue_free()
