extends Node3D

@export var player:Player = null

@onready var doorOut:Door = $"Doors/DoorOut"
@onready var pickable_location:Transform3D = $Objects/Pickable.global_transform
@onready var kickable_location:Transform3D = $Objects/Kickable.global_transform

func _ready():
	if !player:
		printerr("please connect player to Test001")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_locations():
	player.global_transform = $Areas/PlayerLocation.global_transform
	$Objects/Kickable.sleeping = true
	$Objects/Pickable.global_transform = pickable_location
	$Objects/Kickable.global_transform = kickable_location

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


func _on_fall_area_body_entered(body):
	reset_locations()
