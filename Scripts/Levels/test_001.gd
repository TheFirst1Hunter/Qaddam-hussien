extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_pressed():
	$Animations/AnimationPlayer.play("platformUp")


func _on_kickable_hole_kickable_in():
	$Animations/AnimationPlayer.play("Pit")


func _on_pickable_hole_pickable_in():
	$Doors/DoorIn.open()
