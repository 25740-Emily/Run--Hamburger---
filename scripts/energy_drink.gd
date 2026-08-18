extends Area2D


@export var boost_duration: float = 5.0 # 变大持续时间（秒）


func _on_body_entered(body: Node2D) -> void:
	# 检查碰撞到的是否是玩家（通过检查是否有 grow_big 方法）
	if body.has_method("grow_big"):
		body.grow_big(boost_duration) # 触发变大
		queue_free() # 饮料被吃掉后消失
		
@onready var guide_label: Label = $GuideLabel3

var start_y: float = 0.0
var float_speed: float = 2.0   # 上下浮动的速度
var float_range: float = 6.0   # 上下浮动的像素幅度

func _ready() -> void:
	if guide_label:
		start_y = guide_label.position.y

func _process(delta: float) -> void:
	if guide_label:
		# 使用正弦函数 (sin) 实现丝滑的上下漂浮效果
		guide_label.position.y = start_y + sin(Time.get_ticks_msec() * 0.005 * float_speed) * float_range
