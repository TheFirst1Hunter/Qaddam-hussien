extends Node3D

@onready var ray_casts:Array = $"../Legs/RayCasts".get_children() 

func _process(delta):
	pass

func _input(event):
#	if picked_object:
#		picked_object.sleeping = true
	if not event is InputEventKey:
		return
	
	if not event.is_action_pressed("q"):
		return
		
	
	for ray_cast in ray_casts:
		if ray_cast.is_colliding():
			var collider = ray_cast.get_collider()
			var pushDirection : Vector3 = -get_global_transform().basis.z
			print(pushDirection)
#			pushDirection = pushDirection.normalized()        
			if collider.is_in_group("kickable"):
				collider.apply_central_force(pushDirection * get_parent().kick_power)
#				collider.apply_impulse(-collider.get_normal() * 0.1, collider.get_position())
				
				return
