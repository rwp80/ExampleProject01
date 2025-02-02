extends Node3D

@export var player: CharacterBody3D
@export var camera: Array[Camera3D]

var camera_mode: int = 0

signal camera_switched(camera_mode: int)
	
func _ready() -> void:
	camera[camera_mode].make_current()
	camera_switched.emit(camera_mode)
	camera[2] = player.player_camera
	player.camera_controller = self
	self.camera_switched.connect(player.get_basis_from_control_mode)

func _unhandled_input(event):
	if event.is_action_pressed("ui_focus_next"):
		camera_mode = (camera_mode + 1) % camera.size()
		camera[camera_mode].make_current()
		camera_switched.emit(camera_mode)
