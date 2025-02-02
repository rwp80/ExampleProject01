extends CharacterBody3D

# ATTENTION
# About half of this is Godot's standard CharacterBody3D code.
# I didn't want to stray from it too much for this simple example.
# I added features for the character to follow an external Node3D.

@export var navigation_agent: NavigationAgent3D
@export var navigation_target: Node3D

var movement_speed: float = 4.0
var movement_target_position: Vector3

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 1.0
	navigation_agent.target_desired_distance = 1.0
	
	# Make sure to not await during _ready.
	actor_setup.call_deferred()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	refresh_movement_target()

func refresh_movement_target() -> void:
	if navigation_target:
		navigation_agent.set_target_position(navigation_target.global_position)
		return
	
	navigation_agent.set_target_position(global_position)

func _physics_process(delta):
	refresh_movement_target()

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	global_rotation.y = atan2(-velocity.x, -velocity.z)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()
