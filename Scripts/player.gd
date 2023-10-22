extends CharacterBody3D
class_name Player

@onready var head:Node3D = $"Head"
@export var mouse_sensitivity:float = 0.005
@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var kick_power:int = 900

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	collide_with_kicables()
	move_and_slide()

func _input(event):	
	if not event is InputEventMouseMotion:
		return
		
	rotate_y(-event.relative.x * mouse_sensitivity)
		

	head.rotate_x(clamp(((-event.relative.y * mouse_sensitivity)),-1,1))
	
	head.rotation_degrees.x = clamp(((head.rotation_degrees.x)),-80,60)

func collide_with_kicables():
	for col_idx in get_slide_collision_count():
		var col := get_slide_collision(col_idx)
		if col.get_collider() is RigidBody3D :
			col.get_collider().apply_central_impulse(-col.get_normal() * 0.1)
#			col.get_collider().apply_impulse(-col.get_normal() * 0.1, col.get_position())

func drop_pickable():
	$Pickable.picked_object = null
