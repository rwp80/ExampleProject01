extends Node
# Singleton class name: AutoloadInstantQuit

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
