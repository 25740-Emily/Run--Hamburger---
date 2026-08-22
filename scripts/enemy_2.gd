extends CharacterBody2D

@export var rush_speed: float = 300.0   # 突然冲上去的速度
@export var walk_distance: float = 150.0 # 冲上去的总距离

var is_ink_active: bool = false
var start_y: float
var is_triggered: bool = false # 记录陷阱是否被触发了
var move_direction: int = -1   # -1 代表向上冲，1 代表向下走

func _ready() -> void:
	start_y = global_position.y
	velocity = Vector2.ZERO # 一开始静止不动

func _physics_process(_delta: float) -> void:
	if is_triggered:
		velocity.y = move_direction * rush_speed 
		var moved_distance = global_position.y - start_y
		
		# 到顶调头向下
		if move_direction == -1 and moved_distance <= -walk_distance:
			move_direction = 1 
		# 到底调头向上
		elif move_direction == 1 and moved_distance >= 0:
			move_direction = -1 

	move_and_slide()

# 🎯 玩家进入检测区域：触发上下冲撞 + 喷墨汁
func _on_detect_area_body_entered(body: Node2D) -> void:
	if (body.name == "player2" or body.name.begins_with("Hamburger")):
		if not is_triggered:
			is_triggered = true
			start_y = global_position.y
		
		# 💥 必须显式调用喷墨汁逻辑！
		if not is_ink_active:
			trigger_ink_attack()

# 💥 怪物伤害区域：咬玩家掉血
func _on_damagearea_body_entered(body: Node2D) -> void:
	if body.name == "player2" or body.name.begins_with("Hamburger"):
		if body.has_method("take_damage"):
			body.take_damage()

# 🐙 喷墨汁致盲逻辑
func trigger_ink_attack() -> void:
	is_ink_active = true
	
	# 💬 1. 使用场景里已有的 Label 节点
	var text_label = $Label
	text_label.visible = true
	text_label.modulate.a = 1.0
	text_label.position = Vector2(-50, -80) # 初始位置在章鱼上方
	
	# 🎬 让 Label 向上飘动并淡出
	var label_tween = create_tween().set_parallel(true)
	label_tween.tween_property(text_label, "position:y", -130, 0.8)
	label_tween.tween_property(text_label, "modulate:a", 0.0, 0.8)

	# 🖤 2. 屏幕变黑遮罩逻辑
	var overlay = get_tree().get_first_node_in_group("ink_overlay") as ColorRect
	if not overlay:
		overlay = get_tree().root.find_child("InkOverlay", true, false) as ColorRect
		
	if overlay:
		overlay.visible = true
		overlay.z_index = 999
		
		var tween = create_tween()
		tween.tween_property(overlay, "modulate:a", 1.0, 0.25)
		await tween.finished
		
		await get_tree().create_timer(3.0).timeout
		
		var fade_out = create_tween()
		fade_out.tween_property(overlay, "modulate:a", 0.0, 0.5)
		await fade_out.finished
	
	is_ink_active = false
