extends Area2D


var speed = 600
var direction : Vector2 = Vector2.LEFT

func _ready() -> void:
	add_to_group("bullet group")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(direction * speed * delta)
