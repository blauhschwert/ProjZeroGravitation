extends Node2D

const black_hole = preload("res://scenes/black_hole/black_hole.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp_hole = black_hole.instantiate()
	temp_hole.position += Vector2(350,-150)
	temp_hole.set_space_ship_ref($SpaceShip)
	add_child(temp_hole)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
