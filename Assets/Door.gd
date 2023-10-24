extends Node3D

class_name Door

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open():
	$AnimationPlayer.play("open")
	$Audio/Close.stop()
	$Audio/Open.play(0)

func close():
	$AnimationPlayer.play_backwards("open")
	$Audio/Open.stop()
	$Audio/Close.play(0)
