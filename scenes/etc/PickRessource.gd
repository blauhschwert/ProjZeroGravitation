extends Resource
class_name XPPickUp

@export var title : String
@export var icon : Texture2D
@export_multiline var description : String

var player_reference : SpaceShip


func activate():
	#print(title + " picked up")
	pass
