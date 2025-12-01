class_name BlackHole
extends Node2D

var batter_array : Array[TextureRect] = []

const TEXTURE_BATTERY_ICON = preload("res://assets/Pattern.png")
const TEXTURE_BATTERY_STAMP = preload("res://assets/Batterie.png")

@export var max_battery_counter := 0

@onready var battery_h_box: HBoxContainer = $PassiveNode/BatteryHBox

#func _init(battery_count : int) -> void:
	#max_battery_counter = battery_count


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in max_battery_counter:
		var temp_rect : TextureRect = TextureRect.new()
		temp_rect.texture = TEXTURE_BATTERY_ICON
		batter_array.append(temp_rect)
		battery_h_box.add_child(batter_array[i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ActiveNode.scale += Vector2(0.4,0.4) * delta


func _on_inner_circle_body_entered(body: Node2D) -> void:
	if body is SpaceShip:
		pass
