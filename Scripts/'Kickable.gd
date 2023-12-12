extends RigidBody3D

signal kciked

var maxLinearVelocity = 2.0  # Set your desired maximum velocity here
var maxAngularVelocity = 2.0  # Set your desired maximum velocity here

func _physics_process(delta):
#	var currentLinearVelocity = linear_velocity
#
#	var currentSpeed = currentLinearVelocity.length()
#
#	if currentSpeed > maxLinearVelocity:
#
#		currentLinearVelocity = currentLinearVelocity.normalized() * maxLinearVelocity
#		linear_velocity = currentLinearVelocity
	var currentAngularVelocity = angular_velocity

	var currentAngularSpeed = currentAngularVelocity.length()

	if currentAngularSpeed > maxAngularVelocity:
		# If it exceeds the maximum, normalize the angular velocity and scale it back to the maximum
		currentAngularVelocity = currentAngularVelocity.normalized() * maxAngularVelocity
		angular_velocity = currentAngularVelocity

func _kicked():
	emit_signal("kciked")
