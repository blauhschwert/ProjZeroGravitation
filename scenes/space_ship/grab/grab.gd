class_name Grab
extends Node2D

enum Slot {
	EMPTY,
	BATTERY
}
const BATTERY_TEX = preload("uid://bhfk0m0i7cv5m")

var current_slot : Slot = Slot.EMPTY

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("attack"):
		$Sprite2D.frame = 1
		$Area2D.monitoring = true
	else:
		$Battery.texture = null
		$Sprite2D.frame = 0
		current_slot = Slot.EMPTY
		await get_tree().create_timer(0.6).timeout
		queue_free()

func get_slot() -> Slot:
	return current_slot

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Battery:
		$Battery.texture = BATTERY_TEX
		current_slot = Slot.BATTERY
		area.delete() 
