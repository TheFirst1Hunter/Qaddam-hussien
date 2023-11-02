extends Node3D

@export var player:Player = null
@onready var init_pickable_location = $Objects/Pickable.global_transform
@onready var player_fall_area = $Areas/ResetArea.global_transform

func light_on():
	$Lights.visible = true
	for i in range($Fixture.get_child_count()):
		await get_tree().create_timer(0.3).timeout
		$Fixture.get_child(i).on()
		var progress = i / float($Fixture.get_child_count())  # Calculate the progress from 0 to 1
		var variable_to_increase = lerp(0, 1, progress)
		for l in $Lights.get_children():
			l.light_energy = variable_to_increase

func light_off():
	var loop_length = $Fixture.get_child_count()
	
	for i in range(loop_length):
		await get_tree().create_timer(0.3).timeout
		var f = $Fixture.get_child(i)
		f.off()
		
		var progress = i / float(loop_length)  # Calculate the progress from 0 to 1
		var variable_to_decrease = lerp(1, 0, progress)
		for l in $Lights.get_children():
			l.light_energy= variable_to_decrease
	
	$Lights.visible = false


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

func _on_player_in_room_body_entered(body):
	if body is Player:
		light_on()


func _on_player_in_room_body_exited(body):
	if body is Player:
		light_off()
