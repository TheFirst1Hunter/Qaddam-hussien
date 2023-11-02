extends Node3D

@export var player:Player = null

@onready var doorOut:Door = $"Doors/DoorOut"
@onready var pickable_location:Transform3D = $Objects/Pickable.global_transform
@onready var kickable_location:Transform3D = $Objects/Kickable.global_transform

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
		printerr("please connect player to Test001")
	

func start():
	for l in $Lights.get_children():
		if l.has_method("on"):
			l.on()
		if l is OmniLight3D:
			l.omni_range = 10
			
	
	$Audio/AudioStreamPlayer3D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_locations():
	player.globwal_transsform = $Areas/PlayerLocation.global_transform
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
		body.kick_power = 900
		start()


func _on_player_open_door_body_exited(body):
	if body is Player:
		doorOut.close()
		


func _on_fall_area_body_entered(body):
	if body is Player or body.is_in_group("kickable"): 
		reset_locations()
	


func _on_player_in_room_body_entered(body):
	if body is Player:
		light_on()


func _on_player_in_room_body_exited(body):
	if body is Player:
		light_off()
