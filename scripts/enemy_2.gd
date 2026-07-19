extends CharacterBody2D

@export var rush_speed: float = 300.0   # 突然冲上去的速度
@export var walk_distance: float = 150.0 # 冲上去的总距离

var start_y: float
var is_triggered: bool = false # 记录陷阱是否被触发了

func _ready() -> void:
	start_y = global_position.y
	velocity = Vector2.ZERO # 一开始静止不动

var move_direction: int = -1   # -1 代表向上冲，1 代表向下走

func _physics_process(_delta: float) -> void:
	# 如果被触发了，就开启无限上下死循环
	if is_triggered:
		# 根据当前的方向赋予速度
		velocity.y = move_direction * rush_speed 
		
		# 计算当前位置距离最开始原点的绝对距离
		var moved_distance = global_position.y - start_y
		
		# 🔄 到顶了（往上走 Y 是变小的，所以是负数），调头向下
		if move_direction == -1 and moved_distance <= -walk_distance:
			move_direction = 1 
			
		# 🔄 到底了（回到原点），调头向上
		elif move_direction == 1 and moved_distance >= 0:
			move_direction = -1 

	move_and_slide()

# 🎯 这个就是刚连过来的 DetectArea 信号
# 🎯 1. 这个是负责感应玩家走过来、触发怪物冲天而起的信号
func _on_detect_area_body_entered(body: Node2D) -> void:
	if not is_triggered and body.name == "player2":
		is_triggered = true
		start_y = global_position.y

# 💥 2. 这个是怪物自带的伤害区域（比如叫 DamageArea），用来让玩家掉血的信号
# ⚠️ 确保这个名字和你左侧场景树里那个用来咬玩家的 Area2D 节点的信号名字一致
func _on_damagearea_body_entered(body: Node2D) -> void:
	if body.name == "player2":
		if body.has_method("take_damage"):
			body.take_damage()
