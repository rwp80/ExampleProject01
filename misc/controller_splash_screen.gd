extends Control
 
@export_category("Splash Screens")
@export var splash_screen: Array[TextureRect]

@export_category("Timing")
@export var fade_time: float = 0.5
@export var hold_time: float = 2.0

var _fade_tween: Tween

func _ready() -> void:
	# Set all splash screens to transparent
	for i in splash_screen.size():
		splash_screen[i].modulate = Color(1.0,1.0,1.0,0.0)
		#print(i, splash_screen[i].modulate)
	
	# Initialize the tween
	if _fade_tween: _fade_tween.kill()
	_fade_tween = self.create_tween()
	
	# Display splash screens by fading each in/out between transparent/solid
	# Works by adding each screen in the array into one long sequence for the tween
	for i in splash_screen.size():
		_fade_tween.tween_property(splash_screen[i], "modulate", Color(1.0,1.0,1.0,1.0), fade_time)
		_fade_tween.tween_interval(hold_time)
		_fade_tween.tween_property(splash_screen[i], "modulate", Color(1.0,1.0,1.0,0.0), fade_time)
	
	await _fade_tween.finished
	if _fade_tween: _fade_tween.kill()
	
	_go_to_main_shell_scene()

func _unhandled_key_input(event: InputEvent) -> void:
	_go_to_main_shell_scene()

func _go_to_main_shell_scene() -> void:
	get_tree().change_scene_to_file("res://misc/example_room.tscn")
