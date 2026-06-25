extends BaseUpgradeStrategy

func apply_upgrade(ball: Ball):
	ball.speed_multi += 1.5
	ball.upgrade_text.append(upgrade_title)
	queue_free()
