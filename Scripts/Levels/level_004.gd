extends Node3D

@onready var doorOut:Door = $Objects/DoorOut
@onready var doorIn:Door = $Objects/DoorIn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_joker_ground_pickable_in():
	doorOut.open()


func _on_joker_ground_pickable_out():
	doorOut.close()


func _on_joker_ground_player_in():
	doorOut.open()


func _on_joker_ground_player_out():
	doorOut.close()
