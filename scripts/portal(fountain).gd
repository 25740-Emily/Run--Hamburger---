extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Hamburger(player)":
		print("Next Leve!")
		#load a new level
		get_tree().call_deferred("change_scene_to_file","res://scenes/level_2.tscn")
		
		
@onready var guide_label: Label = $GuideLabel

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
		
