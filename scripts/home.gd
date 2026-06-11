extends Control

# Replace this with the actual path to sub menu scene file
@export_file("sub_menu.tscn") var sub_menu_path: String = "res://scenes/sub_menu.tscn"

# Connected to the Homebutton's pressed signal
func _on_homebutton_pressed() -> void:
	if sub_menu_path != "":
		get_tree().change_scene_to_file(sub_menu_path)
	else:
		print("Warning")
	pass # Replace with function body.
