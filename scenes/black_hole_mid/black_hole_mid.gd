class_name BlackHoleMid
extends Node2D

signal hole_destroyed

const TEXTURE_BATTERY_ICON = preload("res://assets/battery/Pattern.png")
const TEXTURE_BATTERY_STAMP = preload("res://assets/battery/Batterie.png")

const ASTROID = preload("res://scenes/astroid/astroid.tscn")

@export var max_battery_counter := 0

var shooting_dirs : Array = [
	Vector2(-1.0,0.0),
	Vector2(-1.0,-1.0),
	Vector2(0.0,-1.0),
	Vector2(1.0,-1.0),
	Vector2(1.0,0.0),
	Vector2(1.0,1.0),
	Vector2(0.0,1.0),
	Vector2(-1.0,1.0),
]

var batter_array : Array[TextureRect] = []
var current_index := 0
var space_ship_ref : SpaceShip = null
var gravitas : bool = false
var is_exploiding : bool = false


@onready var battery_h_box: HBoxContainer = $PassiveNode/BatteryHBox
@onready var explosion: AnimatedSprite2D = %Explosion


#func _init(battery_count : int) -> void:
	#max_battery_counter = battery_count


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ActiveNode/Explosion.visible = false
	for i in max_battery_counter:
		var temp_rect : TextureRect = TextureRect.new()
		temp_rect.texture = TEXTURE_BATTERY_ICON
		batter_array.append(temp_rect)
		battery_h_box.add_child(batter_array[i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !$ActiveNode.scale >= Vector2(5.0,5.0):
		$ActiveNode.scale += Vector2(0.15,0.15) * delta
		# If black hole gets to a specific size it should explode
		if $ActiveNode.scale >= Vector2(5.0,5.0):
			$Exp_Sound.play()
			space_ship_ref.take_damage_neo.emit(1)
			$ActiveNode/Explosion.visible = true
			$ActiveNode/Explosion.play("explosion")
			await explosion.animation_finished
			queue_free()
			
	if gravitas:
		#TODO : please can somebody create a way to fix that the space ship is moving
		# 		to the center of the black hole
		space_ship_ref.position.move_toward($ActiveNode/HoleMidPosition.position,delta)
		
	check_for_batterys()

func set_space_ship_ref(ship_ref : SpaceShip) -> void:
	space_ship_ref = ship_ref
	

func create_astroid() -> void:
	var astroid = ASTROID.instantiate()
	astroid.set_direction(shooting_dirs.pick_random())
	add_child(astroid)

func check_for_batterys() -> void:
	var curr_bats = 0
	for e in batter_array:
		if e.texture == TEXTURE_BATTERY_STAMP:
			curr_bats += 1
		else:
			curr_bats += 0
	
	if curr_bats >= batter_array.size():
		hole_destroyed.emit()
		queue_free()
	else:
		#empty
		pass

func _on_inner_circle_body_entered(body: Node2D) -> void:
	if body is SpaceShip:
		space_ship_ref.set_speed(45)
		if space_ship_ref.grab_ref != null:
			print(space_ship_ref.grab_ref.get_slot())
			batter_array[current_index].texture = TEXTURE_BATTERY_STAMP
			current_index += 1


func _on_outer_circle_body_entered(body: Node2D) -> void:
	if body is SpaceShip:
		space_ship_ref.set_speed(120)


func _on_outer_circle_body_exited(body: Node2D) -> void:
	if body is SpaceShip:
		space_ship_ref.set_speed(180)


func _on_gravita_field_body_entered(_body: Node2D) -> void:
	gravitas = true


func _on_gravita_field_body_exited(_body: Node2D) -> void:
	gravitas = false


func _on_astroid_spawner_timeout() -> void:
	create_astroid()
