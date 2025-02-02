extends Node3D

# ATTENTION INFO
# To use this wall scene, simply add an instaniate it to your main scene
# then alter the Node3D Transform's position and scale as desired.
# The below code will automatically correct each of the relevant scales
# for everything to work correctly.

@export var static_body: StaticBody3D
@export var collision_shape: CollisionShape3D

func _ready() -> void:
	collision_shape.shape.size = scale
	self.mesh.size = scale
	
	collision_shape.scale = Vector3.ONE
	static_body.scale = Vector3.ONE
	self.scale = Vector3.ONE
