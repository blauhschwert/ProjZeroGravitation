class_name Battery
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Explosion.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$Exp_Sound.play()
	$AnimationPlayer.play("explosion")
	await $AnimationPlayer.animation_finished
	$Explosion.visible = true
	$Explosion.play("default")
	await $Explosion.animation_finished
	queue_free()

func delete() -> void:
	queue_free()
