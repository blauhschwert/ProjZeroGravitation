class_name TitleScreen
extends Control

@onready var title_screen: Label = $TitleScreen

func _ready() -> void:
	title_screen.text = ProjectSettings.get_setting("application/config/name")


func _on_exit_pressed() -> void:
	get_tree().quit()
