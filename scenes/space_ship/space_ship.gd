class_name SpaceShip
extends CharacterBody2D

signal emit_damage(amount)
signal player_died

const NEBULAE = preload("res://assets/Spaceships/ship/Nebulae/Nebulae.png")
const AURORAS = preload("res://assets/Spaceships/ship/Auroras/Auroras.png")
const CAPELLA = preload("res://assets/Spaceships/ship/Capella/Capella.png")

var direction : Vector2 = Vector2.ZERO
var max_speed : float = 230.0
var normal_speed : float = 230.0
var boost_speed : float = 550.0

@onready var main_thruster: Line2D = $Thursters/MainThruster
@onready var side_thruster_down: Sprite2D = $Thursters/SideThrusterDown
@onready var side_thruster_up: Sprite2D = $Thursters/SideThrusterUp

var steering_factor : float = 10.0

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("boost"):
		main_thruster.scale = Vector2(1.3,1.3)
		normal_speed = boost_speed
		$BoostTimer.start()
	
	# TODO: changing texture based on a list of items. 
	if event.is_action_pressed("next_skin"):
		$Sprite2D.texture = NEBULAE

func _ready() -> void:
	emit_damage.connect(take_damage)

func _process(delta: float) -> void:
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up","move_down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()

	var desired_velocity := normal_speed * direction
	var steering_vector := desired_velocity - velocity
	
	if $HealthBar.value <= 0.0:
		player_died.emit()
	
	velocity += steering_vector * steering_factor * delta
	move_and_collide(velocity * delta)
	
	if direction.length() > 0.0:
		rotation = velocity.angle()

func set_speed(current_speed : int) -> void:
	normal_speed = current_speed

func take_damage(amount : int) -> void:
	if $HealthBar.value > 0.0:
		$HealthBar.value -= amount


# TODO : creae a tween to shrink the size of the thruster
func _on_boost_timer_timeout() -> void:
	normal_speed = max_speed
	main_thruster.scale = Vector2(1.0,1.0)
