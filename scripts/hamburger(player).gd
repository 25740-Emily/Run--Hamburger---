extends CharacterBody2D

var current_lives: int = 3
@onready var life_bar: HBoxContainer = get_parent().find_child("life bar", true, false)

func _ready() -> void:
	if life_bar:
		life_bar.update_lives(current_lives)
		
func take_damage() -> void:
	current_lives -= 1
	if life_bar:
		life_bar.update_lives(current_lives)
		
	if current_lives <= 0:
		die()
func die() -> void:
	print("Game Over!")
	get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var start_position = Vector2(-32,296)

@export var MAX_JUMPS = 2
var jump_count = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
			# Reset jump count when landing on the ground
			jump_count = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or jump_count < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jump_count += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# handle repawn
	if position.y > 900:
		#repawn
		position = start_position
		
