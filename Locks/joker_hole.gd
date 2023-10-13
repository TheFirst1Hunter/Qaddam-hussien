extends Node3D

signal pickable_in
signal kickabke_in
signal pickable_out
signal kickable_out

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.is_in_group("pickable"):
		emit_signal("pickable_in")
		$AnimationPlayer.play("new_animation")
	if body.is_in_group("kickable"):
		emit_signal("kickabke_in")
		$AnimationPlayer.play("new_animation")


func _on_area_3d_body_exited(body):
	if body.is_in_group("pickable"):
		emit_signal("pickable_out")
		$AnimationPlayer.play_backwards("new_animation")
	if body.is_in_group("kickable"):
		emit_signal("kickable_out")
		$AnimationPlayer.play_backwards("new_animation")
