extends CharacterBody2D

# ⚙️ 参数配置
@export var drop_speed: float = 560.0     # 砸向玩家的超快速度
@export var rise_speed: float = 400.0     # 砸完后升回原位的缓慢速度
@export var drop_distance: float = 300.0  # 向下砸的最大距离
@export var wait_time: float = 0.8        # 砸到底部后停顿的时间（秒）

# 状态控制
enum State { IDLE, DROPPING, WAITING, RISING }
var current_state: State = State.IDLE
var start_y: float
var wait_timer: float = 0.0

func _ready() -> void:
	start_y = global_position.y

func _physics_process(delta: float) -> void:
	match current_state:
		State.IDLE:
			velocity = Vector2.ZERO

		State.DROPPING:
			# 🚀 爆发速度向下砸
			velocity.y = drop_speed
			var moved_distance = global_position.y - start_y
			
			# 达到指定距离，切换到等待状态
			if moved_distance >= drop_distance:
				current_state = State.WAITING
				wait_timer = wait_time

		State.WAITING:
			velocity = Vector2.ZERO
			wait_timer -= delta
			if wait_timer <= 0:
				current_state = State.RISING

		State.RISING:
			# 🎈 缓慢升回天花板
			velocity.y = -rise_speed
			# 回到初始位置
			if global_position.y <= start_y:
				global_position.y = start_y
				current_state = State.IDLE

	move_and_slide()

# 🎯 DetectArea 信号：感应到玩家走到底下，触发砸落！
func _on_detect_area_body_entered(body: Node2D) -> void:
	if current_state == State.IDLE and body.has_method("take_damage"):
		current_state = State.DROPPING

# 💥 DamageArea 信号：砸中玩家，触发扣血！
func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
		print("💥 怪物砸到了玩家！扣血！")
