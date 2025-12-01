class_name Enemy
extends CharacterBody2D

@onready var _anim_player : AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func take_damage() -> void:
	%AnimatedSprite2D.hide()
	$Sprite2D.show()
	_anim_player.play("die")
