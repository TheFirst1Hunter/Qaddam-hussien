extends Node3D

@export var player:Player
@onready var init_player_location = $Areas/PlayerLocation.global_transform
@onready var init_kickable_location = $"Objects/Kickable".global_transform
@onready var door:Door = $"Objects/Door"
@onready var doorIn:Door = $"Objects/DoorIn"

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


func _on_player_in_room_body_entered(body):
	if body is Player:
		light_on()


func _on_player_in_room_body_exited(body):
	if body is Player:
		light_off()
