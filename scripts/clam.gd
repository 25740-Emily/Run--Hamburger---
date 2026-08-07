extends Area2D


@onready var anim: AnimatedSprite2D = $AnimatedSprite2D


var is_closed: bool = false

func _ready() -> void:
	anim.play("open")

func _on_body_entered(body: Node2D) -> void:
	if body.name.begins_with("player2"):
		if not is_closed:
			is_closed = true
			anim.play("close")
			if body.has_method("take_damage"):
				body.take_damage()# Called when the node enters the scene tree for the first time.
