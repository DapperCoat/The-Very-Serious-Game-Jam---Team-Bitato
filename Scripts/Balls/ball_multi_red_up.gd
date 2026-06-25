extends BaseUpgradeStrategy

func apply_upgrade(ball: Ball):
	ball.slot_multi.append("red")
