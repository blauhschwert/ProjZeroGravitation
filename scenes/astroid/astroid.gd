class_name Asteroid
extends Area2D

var directon : Vector2 = Vector2.ZERO
var speed : int = 65

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position += directon * speed * _delta

func set_direction(dir : Vector2) -> void:
	directon = dir

func take_hit() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
