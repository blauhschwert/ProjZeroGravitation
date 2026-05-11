class_name SpaceShip
extends CharacterBody2D

signal emit_damage(amount)
signal player_died

const NEBULAE = preload("res://assets/Spaceships/ship/Nebulae/Nebulae.png")
const AURORAS = preload("res://assets/Spaceships/ship/Auroras/Auroras.png")
const CAPELLA = preload("res://assets/Spaceships/ship/Capella/Capella.png")

var health : float = 25:
	set(value):
		health = max(value, 0)
		%HealthBar.value = value

var nearest_enemy : Enemy
var nearest_enemy_distance : float = 150 + area

var max_health : float = 100:
	set(value):
		max_health = value
		%HealthBar.max_value = value

var recovery : float = 0
var armor : float = 0
var might : float = 1.5
var area : float = 100
var magnet : float = 0:
	set(value):
		magnet = value
		%MagnetCollision.shape.radius = 50 + value
var growth : float = 1


var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value
var total_XP : int = 0
var level : int = 1:
	set(value):
		level = value
		%Level.text = "LvL : " + str(value)
		%Options.show_option()

		
		if level >= 3:
			%XP.max_value = 20
		elif level >= 7:
			%XP.max_value = 40

var direction : Vector2 = Vector2.ZERO
var max_speed : float = 230.0
var normal_speed : float = 230.0
var boost_speed : float = 550.0

@onready var main_thruster: Line2D = $Thursters/MainThruster
@onready var side_thruster_down: Sprite2D = $Thursters/SideThrusterDown
@onready var side_thruster_up: Sprite2D = $Thursters/SideThrusterUp

var steering_factor : float = 10.0

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("test_u"):
		%Options.show_option()
	
	if event.is_action_pressed("boost"):
		main_thruster.scale = Vector2(1.3,1.3)
		normal_speed = boost_speed
		$BoostTimer.start()
	
	# TODO: changing texture based on a list of items. 
	if event.is_action_pressed("next_skin"):
		$Sprite2D.texture = NEBULAE

func _ready() -> void:
	emit_damage.connect(take_damage)
	magnet = 100

func _process(delta: float) -> void:
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up","move_down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()

	var desired_velocity := normal_speed * direction
	var steering_vector := desired_velocity - velocity
	
	if $HealthBar.value <= 0.0:
		player_died.emit()
	
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.separation
	else:
		nearest_enemy_distance = 150 + area
		nearest_enemy = null
	
	velocity += steering_vector * steering_factor * delta
	move_and_collide(velocity * delta)
	check_XP()
	
	health += recovery * delta
	
	if direction.length() > 0.0:
		rotation = velocity.angle()

func set_speed(current_speed : int) -> void:
	normal_speed = current_speed

func take_damage(amount : int) -> void:
	health -= max(amount - armor, 0)

# TODO : creae a tween to shrink the size of the thruster
func _on_boost_timer_timeout() -> void:
	normal_speed = max_speed
	main_thruster.scale = Vector2(1.0,1.0)


func _on_damage_area_body_entered(body: Node2D) -> void:
	take_damage(body.damage)


func _on_timer_timeout() -> void:
	%Collision.set_deferred("disabled",true)
	%Collision.set_deferred("disabled",false)

func gain_XP(amount):
	XP += amount * growth
	total_XP += amount * growth

func check_XP():
	if XP > %XP.max_value:
		XP -= %XP.max_value
		level += 1

func _on_magnet_area_entered(_area: Area2D) -> void:
	if _area.has_method("follow"):
		_area.follow(self)
