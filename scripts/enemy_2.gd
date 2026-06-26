extends CharacterBody2D

@export var rush_speed: float = 300.0   # 突然冲上去的速度
@export var walk_distance: float = 150.0 # 冲上去的总距离

var start_y: float
var is_triggered: bool = false # 记录陷阱是否被触发了

func _ready() -> void:
	start_y = global_position.y
	velocity = Vector2.ZERO # 一开始静止不动

func _physics_process(delta: float) -> void:
# 如果被触发了，就疯狂向上冲
if is_triggered:
velocity.y = -rush_speed

# 计算已经冲了多远
var moved_distance = abs(global_position.y - start_y)

# 冲到指定距离后停下
if moved_distance >= walk_distance:
velocity.y = 0

move_and_slide()

# 🎯 这个就是刚连过来的 DetectArea 信号
func _on_detect_area_body_entered(body: Node2D) -> void:
# 只要还没触发，且进来的确实是 Player，就激活陷阱！
if not is_triggered and body.name == "Hamburger(player)":
is_triggered = true
start_y = global_position.y # 记住开始冲刺时的 Y 坐标

# 💥 这个是负责让玩家掉血的原本的伤害区域信号（保持不变）
func _on_damagearea_body_entered(body: Node2D) -> void:
if body.name == "Hamburger(player)":
if body.has_method("take_damage"):
body.take_damage()


func _on_detect_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
