extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Hamburger(player)":
		start_slide(body)

func start_slide(player: CharacterBody2D) -> void:
	# 1. 暂时禁用玩家自发移动
	player.set_physics_process(false)
	
	# 2. 计算向右侧终点滑行的位置 (+80 像素往右)
	var exit_position = global_position + Vector2(120, -40)
	
	# 3. 滑行动画
	var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_property(player, "global_position", exit_position, 0.3)
	
	# 4. 滑行结束：恢复控制并直接给一个强制向右上的速度 Vector2(600, -600)
	await tween.finished
	player.set_physics_process(true)
	player.velocity = Vector2(1500, -1200) # X为600(向右)，Y为-600(向上)
