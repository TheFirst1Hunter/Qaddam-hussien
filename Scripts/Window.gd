extends Node3D

@onready var camera:Camera3D = $"GlassViewport/Camera3D"
@onready var glass_view_port:SubViewport = $"GlassViewport"

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.global_transform = global_transform
#	camera.rotate_y(180)
#	camera.global_transform.basis.x = Vector3(-1,0,0)
	var m = $Sprite3D.material_override.duplicate()
#	m.set_shader_parameter("albedo_color", Color(1, 1, 1, 1))
	$Sprite3D.material_override = m

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_timer_timeout():
	var material:Material = $Sprite3D.material_override
	var i = glass_view_port.get_texture() 
#	$Sprite3D.texture = i
#	print(material)
#	$Sprite3D.texture = i
#	material.albedo_texture = i
	material.set("shader_param/albedo", i)
