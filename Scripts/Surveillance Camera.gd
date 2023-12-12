extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_talking(talking:bool) -> void:
	if talking:
		$LED.play("LEDOn")
	if not talking:
		$LED.play_backwards("LEDOn")


func _on_led_animation_finished(anim_name):
	if anim_name == "LEDOn":
		$LED.play("emit")
