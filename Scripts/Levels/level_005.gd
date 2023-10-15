extends Node3D

@export var player:Player = null
@onready var init_pickable_location = $Objects/Pickable.global_transform
@onready var player_fall_area = $Areas/ResetArea.global_transform

func _ready():
	if !player:
		printerr("please connect player to level005")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_joker_ground_pickable_in():
	$Animations/AnimationPlayer.play("platform")


func _on_animation_player_animation_finished(anim_name):
	$Objects/DoorOut.open()


func _on_fall_area_body_entered(body):
	if body is Player or body.is_in_group("pickable"):
		player.global_transform = player_fall_area
		$Objects/Pickable.global_transform = init_pickable_location


func _on_player_open_door_body_entered(body):
	if body is Player:
		$Objects/DoorIn.open()


func _on_player_open_door_body_exited(body):
	if body is Player:
		$Objects/DoorIn.close()
