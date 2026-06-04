extends HBoxContainer

# This function will show/hide hearts based on the number of lives
func update_lives(current_lives: int):
	# Get all the heart nodes inside this container
	var hearts = get_children()
	
	# Loop through each heart and decide if it should be visible
	for i in range(hearts.size()):
		# i is 0, 1, 2. If lives is 2, then hearts 0 and 1 are visible, 2 is hidden.
		if i < current_lives:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
# Optional: Initialize with 3 hearts
func _ready():
	update_lives(3)
