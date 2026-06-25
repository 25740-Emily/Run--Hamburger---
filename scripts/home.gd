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
	
@export var sub_menu:Node2D

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Home button is pressed!")
			trigger_pause_menu()
	pass # Replace with function body.

func trigger_pause_menu() -> void:
	get_tree().paused = true
	if sub_menu:
		sub_menu.show()
