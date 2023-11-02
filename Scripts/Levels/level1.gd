extends Node3D

func light_on():
	$"Lights/1-2".visible = true
	for i in range($"Fixture/1-2".get_child_count()):
		await get_tree().create_timer(0.3).timeout
		$"Fixture/1-2".get_child(i).on()
		var progress = i / float($"Fixture/1-2".get_child_count())  # Calculate the progress from 0 to 1
		var variable_to_increase = lerp(0, 1, progress)
		for l in $"Lights/1-2".get_children():
			l.light_energy = variable_to_increase

func light_off():
	var loop_length = $"Fixture/1-2".get_child_count()
	
	for i in range(loop_length):
		await get_tree().create_timer(0.3).timeout
		var f = $"Fixture/1-2".get_child(i)
		f.off()
		
		var progress = i / float(loop_length)  # Calculate the progress from 0 to 1
		var variable_to_decrease = lerp(1, 0, progress)
		for l in $"Lights/1-2".get_children():
			l.light_energy= variable_to_decrease
	
	$"Lights/1-2".visible = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body is Player:
		light_on()


func _on_area_3d_body_exited(body):
	if body is Player:
		light_off()
