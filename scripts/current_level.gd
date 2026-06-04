extends Control
# Inherits from Control, which is the base node for all UI elements

# Gets a reference to the Label child node so we can change its text
# Note: Make sure your child node is exactly named "label" in the scene tree
@onready var level_label : Label = $"level label"

func _ready()-> void:
	# This function runs automatically as soon as this HUD element enters the game world
	update_level_name()

func update_level_name() -> viod:
	# 1. Get the current active root scene node (e.g., Level1 or Level2)
	var current_scene = get_tree().current_scene
	
	if current_scene:
		level_label. text = "Level: " + current_scene.name
	else:
		level_label.text = "Level: Unknown"
