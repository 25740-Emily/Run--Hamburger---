extends Area2D


var win_scene_path = "res://scenes/win.tscn"

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		print("YOU WIN!")
		get_tree().call_deferred("change_scene_to_file", win_scene_path)
	pass # Replace with function body.
