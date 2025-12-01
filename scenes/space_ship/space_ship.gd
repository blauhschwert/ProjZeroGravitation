class_name SpaceShip
extends CharacterBody2D

const CARDINEL = preload("res://assets/Spaceships/ship/Cardinal/cardinel.png")
const HUMMINGBIRD = preload("res://assets/Spaceships/ship/Hummingbird/hummingbird.png")
const ORIOLE = preload("res://assets/Spaceships/ship/Oriole/oriole.png")

const laser_attack = preload("res://scenes/space_ship/laser_attack.tscn")

var direction : Vector2 = Vector2.ZERO
var max_speed : float = 530.0
var normal_speed : float = 530.0
var boost_speed : float = 850.0

var steering_factor : float = 10.0

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("boost"):
		max_speed = boost_speed
		$BoostTimer.start()
	
	if event.is_action_pressed("attack"):
		var temp_attack = laser_attack.instantiate()
		%Attack_Position.add_child(temp_attack)
	
	# TODO: changing texture based on a list of items. 
	if event.is_action_pressed("next_skin"):
		$Sprite2D.texture = HUMMINGBIRD
	
	
 

func _process(delta: float) -> void:
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up","move_down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()
	
	var desired_velocity := max_speed * direction
	var steering_vector := desired_velocity - velocity
	
	velocity += steering_vector * steering_factor * delta
	position += velocity * delta
	
	if direction.length() > 0.0:
		rotation = velocity.angle()

#func set_speed(current_speed : int) -> void:
	#normal_speed = current_speed
	#print(current_speed)

func _on_boost_timer_timeout() -> void:
	max_speed = normal_speed
