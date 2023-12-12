extends Node3D

@onready var animation_player:AnimationPlayer = $"AnimationPlayer"
@onready var right_leg:Node3D = $"RightLeg"
@onready var left_leg:Node3D = $"LeftLeg"
@onready var kick_component:Node3D = $"../Kickable"
@onready var ray_casts:Node3D = $RayCasts


var kickable:RigidBody3D = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_walking()
	
	if Input.is_action_just_pressed("q"):
		if check_if_kickable_in_range():
			handle_kicking()
		else:
			handle_pulling()

func check_if_kickable_in_range():
	for ray_cast in ray_casts.get_children():
		if ray_cast.is_colliding():
			var collider = ray_cast.get_collider()
#			pushDirection = pushDirection.normalized()        
			return collider.is_in_group("kickable")

func handle_pulling():
	if not kickable:
		return
		
		
	var kick_tween:Tween = get_tree().create_tween()
	var kickable_origin = kickable.global_transform.origin
	kickable_origin.y+=1
	kick_tween.tween_property(right_leg,"global_transform:origin",kickable_origin,0.1)
	kick_tween.tween_property(right_leg,"rotation_degrees:x",-45,0.1)
	kick_tween.tween_callback(tween_leg_back)

func handle_kicking():
	var kick_tween:Tween = get_tree().create_tween()
	global_transform.origin
#	kick_tween.tween_property(right_leg,"global_transform:origin",kickabke.global_transform.origin,0.1)
	kick_tween.tween_property(right_leg,"rotation_degrees:x",45,0.1)
	kick_tween.tween_callback(tween_kick_leg_back)

func handle_walking():
	if Input.is_action_pressed("walk"):
		animation_player.play("walk")
	if Input.is_action_just_released("walk"):
		animation_player.stop()
		var right_tween = get_tree().create_tween()
		
		right_tween.tween_property(right_leg,"rotation_degrees:x",0,0.2)
		
		var left_tween = get_tree().create_tween()
		
		left_tween.tween_property(left_leg,"rotation_degrees:x",0,0.2)

func _on_area_3d_body_entered(body):
	if body.is_in_group("kickable"):
		kickable = body


func _on_area_3d_body_exited(body):
	if body.is_in_group("kickable"):
		kickable = null

func tween_leg_back():
	var leg_back_tween = get_tree().create_tween()
	leg_back_tween.tween_property(right_leg,"transform:origin",Vector3(0,0,0),0.05)
	leg_back_tween.tween_property(right_leg,"rotation_degrees:x",0,0.05)

func tween_kick_leg_back():
	var kick_leg_tween = get_tree().create_tween()
	kick_leg_tween.tween_property(right_leg,"rotation_degrees:x",0,0.1)
	kick_component.kick()
