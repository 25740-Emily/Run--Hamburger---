extends Area2D


var win_scene_path = "res://scenes/win.tscn"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player2" or body.name == "Hamburger(player)":
		print("YOU WIN!")
		get_tree().call_deferred("change_scene_to_file", win_scene_path)
