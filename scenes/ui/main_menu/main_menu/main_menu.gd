class_name MainMenu
extends Control

func _ready():
	pass

func _on_exit_button_pressed():
	get_tree().quit()

func _on_title_screen_main_open_options() -> void:
	$TitleScreenMain.hide()
	$Options.show()

func _on_options_close_options() -> void:
	$Options.hide()
	$TitleScreenMain.show()

func _on_title_screen_main_open_credits() -> void:
	$TitleScreenMain.hide()
	$Credits.show()

func _on_credits_close_credits() -> void:
	$Credits.hide()
	$TitleScreenMain.show()
