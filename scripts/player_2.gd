extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# 🩸 受伤处理
func take_damage() -> void:
	# 扣除全局血量
	Global.current_health -= 1
	print("玩家受伤！当前剩余生命:", Global.current_health)
	
	# 受伤闪红效果
	var tween = create_tween()
	modulate = Color.RED
	tween.tween_property(self, "modulate", Color.WHITE, 0.2)
	
	# 检查死亡
	if Global.current_health <= 0:
		die()

# ☠️ 死亡处理
func die() -> void:
	print("玩家死亡，重新开始关卡！")
	Global.reset_health() # 重新开始时恢复满血
	# 💡 使用 call_deferred 延迟调用重载场景，避免物理回调冲突
	get_tree().call_deferred("reload_current_scene")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("player_down") and position.y < 962:
		position.y += 10
	if Input.is_action_pressed("player_up") and position.y > 324:
		position.y -= 10
	if Input.is_action_pressed("player_left"):  
		position.x -= 10
	if Input.is_action_pressed("player_right"): 
		position.x += 10
