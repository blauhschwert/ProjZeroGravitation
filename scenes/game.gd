extends Node2D

const black_hole = preload("res://scenes/black_hole/black_hole.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp_hole = black_hole.instantiate()
	add_child(temp_hole)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
