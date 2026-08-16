extends CharacterBody2D


# ⚙️ 极速鲨鱼参数设置
@export var max_speed: float = 600.0       # 极快的巡航速度（比小鸟快很多！）
@export var acceleration: float = 1200.0   # 转向/加速时的爆发力
@export var swim_distance: float = 400.0   # 左右游动的巡航半径
@export var start_facing_right: bool = true # 初始是否朝右游

var start_x: float
var direction: int = 1

@onready var sprite: Sprite2D = $Sprite2D # 如果是 Sprite2D 请把类型改为 Sprite2D

func _ready() -> void:
	# 记录初始 X 坐标
	start_x = global_position.x
	direction = 1 if start_facing_right else -1
	update_sprite_direction()

func _physics_process(delta: float) -> void:
	# 计算离开初始位置的绝对距离
	var moved_distance = global_position.x - start_x

	# 🔄 往右游且到达右边界 -> 调头向左
	if direction == 1 and moved_distance >= swim_distance:
		direction = -1
		update_sprite_direction()
	# 🔄 往左游且到达左边界 -> 调头向右
	elif direction == -1 and moved_distance <= -swim_distance:
		direction = 1
		update_sprite_direction()

	# 🚀 水中爆发极速平滑移动
	var target_velocity_x = direction * max_speed
	velocity.x = move_toward(velocity.x, target_velocity_x, acceleration * delta)
	velocity.y = 0.0 # 保持在固定水深水平游动

	move_and_slide()

# 🪞 图像转向
func update_sprite_direction() -> void:
	if sprite:
		# direction 为 1 (向右) 时不翻转，为 -1 (向左) 时翻转
		# (如果你画的鲨鱼初始嘴巴朝左，把 false 和 true 对调即可)
		sprite.flip_h = (direction == 1)

# 💥 咬人扣血信号 (绑定 DamageArea 的 body_entered)

func _on_damageare_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
		print("🦈 鲨鱼咬到了玩家！触发扣血！")
	pass # Replace with function body.
