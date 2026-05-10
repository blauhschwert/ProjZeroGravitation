class_name TitleScreen
extends Control

signal open_options
signal open_credits

@warning_ignore("unused_signal")
signal hide_title_screen

@onready var title_screen: Label = $TitleScreen

func _ready() -> void:
	title_screen.text = ProjectSettings.get_setting("application/config/name")

func _on_start_button_pressed() -> void:
	hide()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	open_options.emit()

func _on_credits_pressed() -> void:
	open_credits.emit()
