extends Node3D

@export var player:Player
@onready var init_player_location = player.global_transform
@onready var init_kickable_location = $"Objects/Kickable".global_transform
@onready var door:Door = $"Objects/Door"
@onready var doorIn:Door = $"Objects/DoorIn"

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset():
	player.global_transform = init_player_location
	$"Objects/Kickable".global_transform = init_kickable_location

func _on_ball_fall_body_entered(body):
	if body is Player or body.is_in_group("kickable"):
		reset()



func _on_kickable_hole_kickable_in():
	door.open()


func _on_player_open_door_body_exited(body):
	if body is Player:
		doorIn.close()


func _on_player_open_door_body_entered(body):
	if body is Player:
		doorIn.open()
