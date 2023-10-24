extends Node3D

signal pickable_in

@export var player:Player

# Called when the node enters the scene tree for the first time.
func _ready():
	if !player:
		printerr("Please link the player to the pickable hole")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.is_in_group("pickable"):
		player.drop_pickable()
		emit_signal("pickable_in")
		var tween = get_tree().create_tween()
		tween.tween_property(body,"global_transform",$Center.global_transform,0.5)
		body.freeze = true
		$AudioStreamPlayer3D.play()
		emit_signal("kickable_in")

