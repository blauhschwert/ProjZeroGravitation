class_name MainGame
extends Node2D

enum GameStates {TITLE, GAME, PAUSED,}

var game_state : GameStates = GameStates.TITLE
var level_counter = 0

@onready var main_menu: CanvasLayer = $MainMenu

@onready var space_ship: SpaceShip = $SpaceShip
@onready var spawner: Spawner = $Spawner


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_state = GameStates.TITLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match game_state:
		GameStates.TITLE:
			main_menu.show()
		GameStates.GAME:
			pass
		GameStates.PAUSED:
			pass
		
	# loop music
	if not $Music.playing:
		$Music.play()

func show_level_text() -> void:
	%LevelCounter.text = "Level : " + str(level_counter)

func increase_level_counter() -> void:
	level_counter += 1

# TODO : add a config to start movements and other inputs on game start
func _set_player_inputs() -> void:
	pass


func _on_main_menu_game_started() -> void:
	game_state = GameStates.GAME
