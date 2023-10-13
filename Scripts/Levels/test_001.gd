extends Node3D

@onready var doorOut:Door = $"Doors/DoorOut"

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


func _on_player_open_door_body_entered(body):
	if body is Player:
		doorOut.open()
		body.kick_power = 700


func _on_player_open_door_body_exited(body):
	if body is Player:
		doorOut.close()
