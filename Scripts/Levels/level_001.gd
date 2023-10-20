extends Node3D

@onready var exit_door:Door = $"Objects/Door"

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.3).timeout
	
	for l in $Fixtures.get_children():
		await get_tree().create_timer(0.3).timeout
		l.on()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_pressed():
	exit_door.open()


func _on_room_body_exited(body):
	if not body is Player:
		return
	await get_tree().create_timer(0.3).timeout
	
	for l in $Fixtures.get_children():
		await get_tree().create_timer(0.3).timeout
		l.off()

