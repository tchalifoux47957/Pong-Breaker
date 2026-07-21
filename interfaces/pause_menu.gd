extends Control


var paused: bool = false
var canPause: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") && canPause:
		paused = !paused
		if paused:
			pause()
		else:
			unpause()

func pause() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	paused = true
	show()
	if NetworkMaster.singleplayer:
		get_tree().set_pause(true)
	else:
		Global.isGamePaused = true

func unpause() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	paused = false
	hide()
	if NetworkMaster.singleplayer:
		get_tree().set_pause(false)
	else:
		Global.isGamePaused = false


func _on_return_button_pressed() -> void:
	unpause()


func _on_quit_button_pressed() -> void:
	if NetworkMaster.singleplayer:
		get_tree().set_pause(false)
	get_tree().change_scene_to_file("res://interfaces/main_menu.tscn")
	
