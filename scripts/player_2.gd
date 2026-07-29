extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("player_down") and position.y < 962:
		position.y += 10
	if Input.is_action_pressed("player_up") and position.y > 324:
		position.y -= 10
	if Input.is_action_pressed("player_left"):  
		position.x -= 10
	if Input.is_action_pressed("player_right"): 
		position.x += 10
