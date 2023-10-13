extends Node3D

@onready var door:Door = $"Objects/Door"
@onready var doorIn:Door = $"Objects/DoorIn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pickable_hole_pickable_in():
	door.open()


func _on_player_open_door_body_entered(body):
	if body is Player:
		doorIn.open()


func _on_player_open_door_body_exited(body):
	if body is Player:
		doorIn.close()
