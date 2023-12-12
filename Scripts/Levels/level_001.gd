extends Node3D

@onready var exit_door:Door = $"Objects/Door"
var start_of_the_game_index = 0
var intinterruption_count = 0
var is_player_in_room = true
var player_in_button_area_once = true

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
	await get_tree().create_timer(0.5).timeout
	light_on()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $Lights.visible or not is_player_in_room:
		return
		
	if Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down") || Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left"):
		if $Audio/StartOfTheGame.playing:
			if not $Audio/PlayerMovesBeforeTutorialEnds1.playing and not $Audio/PlayerMovesBeforeTutorialEnds2.playing:
				start_of_the_game_index = max(0,$Audio/StartOfTheGame.get_playback_position() - 1)
				if intinterruption_count < 2:
					$Audio/StartOfTheGame.stop()
					
				if intinterruption_count == 1:
					$Audio/PlayerMovesBeforeTutorialEnds2.play()
					
				if intinterruption_count == 0:
					$Audio/PlayerMovesBeforeTutorialEnds1.play()
				
				intinterruption_count += 1
				


func _on_button_button_pressed():
	if not $Audio/StartOfTheGame.playing and not $Audio/PlayerMovesBeforeTutorialEnds1.playing and not $Audio/PlayerMovesBeforeTutorialEnds2.playing:
		exit_door.open()
		is_player_in_room = false
		$Audio/WhenDoorOpens.play()
	else:
		start_of_the_game_index = max(0,$Audio/StartOfTheGame.get_playback_position() - 1)
		$Audio/PlayerMovesBeforeTutorialEnds1.stop()
		$Audio/PlayerMovesBeforeTutorialEnds2.stop()
		$Audio/StartOfTheGame.stop()
		$Audio/PLayerPressesTheButtonBeforeTutorialEnds.play()


func _on_room_body_exited(body):
	if not body is Player:
		return
	light_off()
#	for f in $Fixture.get_children():
#		await get_tree().create_timer(0.3).timeout
#		f.off()
#	$Lights.visible = false
	



func _on_room_body_entered(body):
	light_on()
#	for l in $Fixture.get_children():
#		l.on()
#	$Lights.visible = true


func _on_player_moves_before_tutorial_ends_finished():
	await get_tree().create_timer(1).timeout
	$Audio/StartOfTheGame.play(start_of_the_game_index)


func _on_p_layer_presses_the_button_before_tutorial_ends_finished():
	await get_tree().create_timer(1).timeout
	$Audio/StartOfTheGame.play(start_of_the_game_index)


func _on_player_moves_before_tutorial_ends_2_finished():
	await get_tree().create_timer(1).timeout
	$Audio/StartOfTheGame.play(start_of_the_game_index)


func _on_when_door_opens_finished():
	pass
#	await get_tree().create_timer(1).timeout
#	$Audio/StartOfTheGame.play(start_of_the_game_index)


func _on_button_area_body_entered(body):
	if not body is Player:
		return
		
	if player_in_button_area_once:
		start_of_the_game_index = max(0,$Audio/StartOfTheGame.get_playback_position() - 1)
		$Audio/PlayerMovesBeforeTutorialEnds1.stop()
		$Audio/PlayerMovesBeforeTutorialEnds2.stop()
		$Audio/StartOfTheGame.stop()
		$Audio/WhenDoorOpens.play()
		player_in_button_area_once = false
