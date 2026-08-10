extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player2" or body.name.begins_with("Hamburger") or body.name.begins_with("player"):
		Global.score += 1
		print("score +1！total:", Global.score)
		
		call_deferred("queue_free")
