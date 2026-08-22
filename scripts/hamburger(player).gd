extends CharacterBody2D

var current_lives: int = 3
@onready var life_bar: HBoxContainer = get_parent().find_child("life bar", true, false)

func _ready() -> void:
	if life_bar:
		life_bar.update_lives(current_lives)
		
func take_damage() -> void:
	Global.current_health -= 1
	print("玩家受伤！当前剩余生命:", Global.current_health)
	current_lives -= 1
	if life_bar:
		life_bar.update_lives(current_lives)
		
	var tween = create_tween()
	modulate = Color.RED
	tween.tween_property(self, "modulate", Color.WHITE, 0.2)
	
	# 检查是否死亡
	if Global.current_health <= 0:
		die()
	
	
	if current_lives <= 0:
		die()
func die() -> void:
	print("Game Over!")
	Global.reset_health() # 重新开始时把血量恢复满
	get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over.tscn")


const SPEED = 300.0
var jump_velocity: float = -400.0
var start_position = Vector2(-32,296)

@export var MAX_JUMPS = 2
var jump_count = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
			# Reset jump count when landing on the ground
			jump_count = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or jump_count < MAX_JUMPS:
			velocity.y = jump_velocity
			jump_count += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# 获取输入方向
	var direction := Input.get_axis("left", "right")
	
	if direction:
		# 有按键输入时，正常控制左右移动
		velocity.x = direction * SPEED
	else:
		# 没有按键输入时：
		if is_on_floor():
			# 只有踩在地面上才迅速停下
			velocity.x = move_toward(velocity.x, 0, SPEED)
		else:
			# ✈️ 在空中时使用平滑减速（例如每秒只衰减 200 速度），保留被弹飞的抛物线惯性！
			velocity.x = move_toward(velocity.x, 0, 200.0 * delta)

	move_and_slide()
	
	# handle repawn
	if position.y > 900:
		#repawn
		position = start_position
		
# 🧪 变大并跳得更高的函数
func grow_big(duration: float = 5.0) -> void:
	# 1. 提升跳跃高度（数值越负跳得越高，乘以 1.4 倍）
	var default_jump = jump_velocity
	jump_velocity = default_jump * 1.4

	# 2. 放大角色体型
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.2)
	
	# 3. 等待持续时间结束
	await get_tree().create_timer(duration).timeout
	
	# 4. 恢复原本的跳跃高度与体型
	jump_velocity = default_jump
	var shrink_tween = create_tween()
	shrink_tween.tween_property(self, "scale", Vector2.ONE, 0.2)
