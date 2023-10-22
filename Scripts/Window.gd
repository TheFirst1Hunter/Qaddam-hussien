extends Node3D

@onready var camera:Camera3D = $"GlassViewport/Camera3D"
@onready var glass_mesh:MeshInstance3D = $"Window/Glass"
@onready var glass_view_port:SubViewport = $"GlassViewport"

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.global_transform = global_transform
	camera.rotate_y(-90)
	camera.transform.origin.x +=0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_timer_timeout():
	var material:Material = $Window/Glass.get_active_material(0)
	var i = glass_view_port.get_texture() 
	$Sprite3D.texture = i
#	print(material)
#	$Sprite3D.texture = i
	material.albedo_texture = i
	material.set("albedo_texture",i)
