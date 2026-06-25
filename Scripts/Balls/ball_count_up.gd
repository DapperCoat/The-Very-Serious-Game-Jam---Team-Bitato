extends BaseUpgradeStrategy

func apply_upgrade(ball: Ball):
	ball.ball_count += 1
	ball.upgrade_text.append(upgrade_title)
	queue_free()
