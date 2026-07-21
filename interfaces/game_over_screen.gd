extends Control

signal _rematch_requested
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var reason_label: Label = $Panel/VBoxContainer/GameOverReasonLabel
@onready var rematch_button: Button = $Panel/VBoxContainer/HBoxContainer/RematchButton

func _ready() -> void:
	NetworkMaster.player_left.connect(show_player_leave)
	
func show_win(player: int = 1) -> void:
	reason_label.text = "Player " + str(player) + " wins!"
	animation_player.play("appear")
	Global.isGamePaused = true
	if player != 1:
		reason_label.modulate = Color.RED
	else:
		reason_label.modulate = Color.YELLOW

func show_player_leave() -> void:
	rematch_button.hide()
	animation_player.play("appear")
	Global.isGamePaused = true
	reason_label.text = "Not enough players!"
	reason_label.modulate = Color.RED


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://interfaces/main_menu.tscn")


func _on_rematch_button_pressed() -> void:
	animation_player.play("appear", -1, -1.0, true)
	await animation_player.animation_finished
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	_rematch_requested.emit()
	Global.isGamePaused = false
