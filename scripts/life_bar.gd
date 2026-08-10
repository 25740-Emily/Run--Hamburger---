extends HBoxContainer

func _ready() -> void:
	update_lives(Global.current_health)

func _process(_delta: float) -> void:
	update_lives(Global.current_health)

# This function will show/hide hearts based on the number of lives
func update_lives(current_lives: int) -> void:
	# Get all the heart nodes inside this container
	var hearts = get_children()
	
	# Loop through each heart and decide if it should be visible
	for i in range(hearts.size()):
		if i < current_lives:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
