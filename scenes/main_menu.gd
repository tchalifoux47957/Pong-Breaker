extends Control

@onready var quit_panel: PanelContainer = $QuitPanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_button_pressed() -> void:
	quit_panel.show()


func _on_back_button_pressed() -> void:
	quit_panel.hide()


func _on_quit_accept_button_pressed() -> void:
	get_tree().quit()


func _on_mp_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mp_world.tscn")


func _on_sp_button_pressed() -> void:
	NetworkMaster.singleplayer = true
	get_tree().change_scene_to_file("res://scenes/sp_world.tscn")
