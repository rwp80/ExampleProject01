extends CharacterBody3D

# ATTENTION
# About half of this is Godot's standard CharacterBody3D code.
# I didn't want to stray from it too much for this simple example.
# My own input control scripts are usually very different from this.

var camera_controller: Node3D
@export var basis_iso: Node3D
@export var player_camera: Camera3D

var control_mode: int
var control_basis: Basis

const SPEED: float = 6.0
# ATTENTION sorry, no jumping in this game! Godot standard code.
# const JUMP_VELOCITY: float = 4.5

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# ATTENTION sorry, no jumping in this game! Godot standard code.
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (control_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if control_mode != 2:
			global_rotation.y = atan2(-direction.x, -direction.z)
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func get_basis_from_control_mode(camera_mode: int) -> void:
	control_mode = camera_mode
	match camera_mode:
		0:
			control_basis = Basis.IDENTITY
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		1:
			control_basis = basis_iso.transform.basis
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		2:
			control_basis = transform.basis
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	transform = transform.orthonormalized()
	
	if (event is InputEventMouseMotion) and control_mode == 2:
		global_rotation.y += event.relative.x * -0.001
		#global_rotation.x += event.relative.y * -0.001 # NOTE we don't need vertical tilting for this game.
		control_basis = transform.basis
