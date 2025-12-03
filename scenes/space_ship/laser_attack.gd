extends Node2D

const BATTERY = preload("res://scenes/battery/battery.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("attack")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Asteroid:
		var temp_pos = area.global_position
		area.take_hit()
		var temp_battery = BATTERY.instantiate()
		temp_battery.global_position = temp_pos
		get_node("/root/Game").add_child.call_deferred(temp_battery)
