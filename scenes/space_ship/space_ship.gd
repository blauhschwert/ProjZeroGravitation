class_name SpaceShip
extends CharacterBody2D

signal take_damage_neo(amount)
signal player_died

const CARDINEL = preload("res://assets/Spaceships/ship/Cardinal/cardinel.png")
const HUMMINGBIRD = preload("res://assets/Spaceships/ship/Hummingbird/hummingbird.png")
const ORIOLE = preload("res://assets/Spaceships/ship/Oriole/oriole.png")

const laser_attack = preload("res://scenes/space_ship/laser_attack.tscn")
const grab = preload("res://scenes/grab/grab.tscn")

var direction : Vector2 = Vector2.ZERO
var max_speed : float = 230.0
var normal_speed : float = 230.0
var boost_speed : float = 550.0
var grab_ref : Grab = null

# hold button
var threshold_time : float = 0.2
var timer : float = 0.2
var action_started = false

var steering_factor : float = 10.0

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("boost"):
		normal_speed = boost_speed
		$BoostTimer.start()
	
	#var temp_attack = laser_attack.instantiate()
	#%Attack_Position.add_child(temp_attack)
	
	# TODO: changing texture based on a list of items. 
	if event.is_action_pressed("next_skin"):
		$Sprite2D.texture = HUMMINGBIRD

func _ready() -> void:
	take_damage_neo.connect(take_damage)

func _process(delta: float) -> void:
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up","move_down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()

	var desired_velocity := normal_speed * direction
	var steering_vector := desired_velocity - velocity
	
	attack_button(delta)
	
	if $HealthBar.value <= 0.0:
		player_died.emit()
	
	velocity += steering_vector * steering_factor * delta
	position += velocity * delta
	
	if direction.length() > 0.0:
		rotation = velocity.angle()

func set_speed(current_speed : int) -> void:
	normal_speed = current_speed

func move_to_center(hole_mid_point : Vector2) -> void:
	position += hole_mid_point

func take_damage(amount : int) -> void:
	if $HealthBar.value > 0.0:
		$HealthBar.value -= amount

func attack_button(_delta : float) -> void:
	if Input.is_action_just_pressed("attack"):
		action_started = true
	
	if Input.is_action_pressed("attack") and action_started:
		timer += _delta
	
	if timer >= threshold_time and action_started:
		action_started = false
		timer = 0
		# print("hold")
		grab_ref = grab.instantiate()
		grab_ref.position = %Attack_Position.position
		add_child(grab_ref)
	
	if Input.is_action_just_released("attack"):
		if timer < threshold_time and action_started:
			# print("press")
			var temp_attack = laser_attack.instantiate()
			%Attack_Position.add_child(temp_attack)
		action_started = false
		timer = 0
 

func _on_boost_timer_timeout() -> void:
	normal_speed = max_speed
