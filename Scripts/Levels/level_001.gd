extends Node3D

@onready var exit_door:Door = $"Objects/Door"

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
	pass


func _on_button_button_pressed():
	exit_door.open()


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
