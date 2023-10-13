extends Node3D

signal kickable_in

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.is_in_group("kickable"):
		var tween = get_tree().create_tween()
		tween.tween_property(body,"global_transform",$Center.global_transform,0.5)
		body.freeze = true
		emit_signal("kickable_in")
