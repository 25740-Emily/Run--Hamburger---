extends Area2D



func _on_body_entered(body: Node2D) -> void:
	# If the object touching the coin is named "Hamburger(player)", collect it 
	if body.name == "Hamburger(player)":
		print("Coin collected! +1 Score")
		call_deferred("queue_free")# Destroys the coin instantly
