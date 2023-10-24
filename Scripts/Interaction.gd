extends Node3D

@onready var ray_cast:RayCast3D = $"../Head/Camera3D/RayCast3D"
@onready var pick_area:Node3D = $"../Head/PickArea"
@export var pick_audio:AudioStreamPlayer3D 

var picked_object:RigidBody3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if picked_object:
		picked_object.global_transform.origin = pick_area.global_transform.origin

func _input(event):
	if picked_object:
		picked_object.sleeping = true
	if not event is InputEventKey:
		return
	
	if not event.is_action_pressed("e"):
		return
		
	if picked_object:
		picked_object.sleeping = false
		picked_object.freeze = false
		picked_object = null
		return
	
	if ray_cast.is_colliding():
		
		var collider = ray_cast.get_collider()
		
		if collider.is_in_group("pickable"):
			pick_audio.play()
			picked_object = collider
			picked_object.sleeping = true
			handle_pickable()
			
			return

func handle_pickable() -> void:
	pass
#	var tween = get_tree().create_tween()
#
#	tween.tween_property(picked_object,"global_transform:origin",pick_area.global_transform.origin,0.2)

