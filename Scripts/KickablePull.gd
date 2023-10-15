extends Node3D

var kickable_in_area:RigidBody3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.is_in_group("kickable"):
		kickable_in_area = body


func _on_area_3d_body_exited(body):
	if body.is_in_group("kickable"):
		kickable_in_area = body

func _input(event):
#	if picked_object:
#		picked_object.sleeping = true
	if not event is InputEventKey:
		return
	
	if not event.is_action_pressed("q"):
		return
		
	
	if !kickable_in_area:
		return
		
	var pushDirection : Vector3 = get_global_transform().basis.z
	kickable_in_area.apply_central_force(pushDirection * 100)
