extends Node2D

var bullet_prefab = preload("res://scenes/bullet.tscn")

func _on_timer_timeout() -> void:
	pass # Replace with function body.
	var bullet = bullet_prefab.instantiate()
	add_child(bullet)
