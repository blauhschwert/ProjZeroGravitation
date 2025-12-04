extends Node2D

const black_hole_weak = preload("res://scenes/black_hole_weak/black_hole_weak.tscn")
const black_hole_mid = preload("res://scenes/black_hole_mid/black_hole_mid.tscn")
const black_hole_strong = preload("res://scenes/black_hole_strong/black_hole_strong.tscn")

var level_counter = 0
var black_hole_counter := 0
var black_holes : Array = [
	black_hole_weak,
	black_hole_mid,
	black_hole_strong
]

var black_hole_positon : Array = [
	Vector2(100,-100),
	Vector2(-100,-100),
	Vector2(-100,100),
	Vector2(-100,100),
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	create_black_hole()
	$SpaceShip.player_died.connect(create_game_over_screen)
	# print(Globals.pick_drop(Globals.drop_table))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	%LevelCounter.text = "Level : " + str(level_counter)
	
	create_holes()
	
	# loop music
	if not $Music.playing:
		$Music.play()


func increase_level_counter() -> void:
	level_counter += 1
	black_hole_counter -= 1

func create_black_hole() -> void:
	var hole_pos_scalar = randi_range(1,3)
	var temp_hole = black_holes.pick_random().instantiate()
	temp_hole.hole_destroyed.connect(increase_level_counter)
	temp_hole.global_position += $SpaceShip.global_position + hole_pos_scalar * black_hole_positon.pick_random()
	temp_hole.set_space_ship_ref($SpaceShip)
	black_hole_counter += 1
	add_child(temp_hole)

# naive function to spwan at least holes at the momment 
func create_holes() -> void:
	if black_hole_counter < 0: 
		create_black_hole()
		create_black_hole()
	elif black_hole_counter <= 1:
		create_black_hole()

func create_game_over_screen() -> void:
	$CanvasLayer/GameOverPanel.visible = true
	set_process(false)
