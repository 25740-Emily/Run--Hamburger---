extends CharacterBody2D


@export var speed: float = 60.0
@export var walk_distance: float = 80.0

var start_x: float
var direction: int = 1 

func _ready() -> void:
	start_x = global_position.x
	
	velocity.x = direction * speed
	
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += 980 * delta
	
	
	var moved_distance = abs(global_position.x - start_x)
	
	
	if moved_distance >= walk_distance:
		direction *= -1                    
		$Sprite2D.flip_h = (direction == -1)
		start_x = global_position.x        
	
	
	velocity.x = direction * speed
	move_and_slide()
