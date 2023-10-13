extends Node3D

@onready var ray_cast:RayCast3D = $"../Head/Camera3D/RayCast3D"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if not event is InputEventKey:
		return
	
	if not event.is_action_pressed("e"):
		return
	
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		print(collider.name)
		if collider is InteractionButton:
			collider.press()
	
