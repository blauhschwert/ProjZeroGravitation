class_name UpgradeOption
extends TextureButton

@export var weapon : Weapon:
	set(value):
		weapon = value
		
		texture_normal = value.texture
		$Label.text = "LvL: " + str(weapon.level + 1)
		$Description.text = value.upgrades[value.level - 1].description


func _on_icon_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		#print(weapon.title)
		weapon.upgrade_item()
		get_parent().close_option()
