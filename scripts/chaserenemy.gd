extends CharacterBody2D


@export var player_node: Node2D  # 在编辑器里拖入你的 Player 节点
@export var follow_speed: float = 12.0 # 追赶时的平滑插值速度

# ⚙️ 距离设置（根据你的游戏画面像素大小调整）
@export var distance_full_health: float = 300.0  # 满血(3血)时的安全跟随距离（隔着屏幕后方）
@export var distance_one_hit: float = 180.0      # 掉1血(剩2血)时的贴近距离
@export var distance_two_hit: float = 80.0       # 掉2血(剩1血)时的紧逼距离
@export var distance_caught: float = 0.0         # 掉3血(剩0血)时彻底抓到玩家

func _process(delta: float) -> void:
	# 确保能找到玩家
	if not player_node:
		player_node = get_parent().get_node_or_null("Hamburger(player)")
		if not player_node:
			return

	# 1. 根据 Global 当前血量，计算目标 X 轴距离
	var target_distance: float = distance_full_health

	match Global.current_health:
		3:
			target_distance = distance_full_health
		2:
			target_distance = distance_one_hit
		1:
			target_distance = distance_two_hit
		0:
			target_distance = distance_caught
		_:
			if Global.current_health > 3:
				target_distance = distance_full_health
			else:
				target_distance = distance_caught

	# 2. 只计算 X 轴的目标位置（水平追赶）
	var target_x = player_node.global_position.x - target_distance

	# 3. 只在 X 轴上做平滑插值，不修改 global_position.y
	global_position.x = lerp(global_position.x, target_x, follow_speed * delta)

	# 4. 检查是否彻底追上玩家
	if Global.current_health <= 0 and abs(global_position.x - player_node.global_position.x) < 10.0:
		on_player_caught()

# 💥 彻底抓到玩家时的逻辑
func on_player_caught() -> void:
	print("🚨 追逐者抓到了玩家！Game Over！")
	# 可以在这里播放抓捕动画、音效，或者跳转到死亡/结算界面
