extends Node2D

signal _join_button_pressed_(newLobbyID: int)

const PADDLE = preload("uid://dqojax6xtqdwu")
const BALL = preload("uid://dqgio6jn88ad2")

@onready var game_master: GameMaster = $GameMaster

var players: Array[StaticBody2D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if NetworkMaster.inGame == true:
		_on_player_joined()
	NetworkMaster.player_joined.connect(_on_player_joined)
	NetworkMaster.host_created.connect(_on_host_created)

func _on_host_created() -> void:
	spawn_player(multiplayer.get_unique_id(), true)
	multiplayer.peer_connected.connect(spawn_player)

func spawn_player(peerID: int, isHost: bool = false) -> void:
	var new_player := PADDLE.instantiate() as StaticBody2D
	new_player.name = str(peerID)
	add_child(new_player)
	if isHost:
		initialize_player(new_player, true)
	else:
		initialize_player(new_player)
	$UI/LobbyScreen.hide()

func initialize_player(player: StaticBody2D, isHost: bool = false) -> void:
	if isHost:
		player.position = Vector2( 64, get_viewport_rect().size.y / 2)
	else:
		player.position = Vector2(get_viewport_rect().size.x - 64, get_viewport_rect().size.y / 2 )
	players.append(player)
	
	if players.size() == 2:

		
		if $UI/WaitingPopup.visible:
			$UI/WaitingPopup/AnimationPlayer.stop()
			$UI/WaitingPopup.hide()
			
			
		var ball := BALL.instantiate() as RigidBody2D
		add_child(ball)
		$GameMaster.ball = ball
		ball.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		$GameMaster/Reset.start()
	else:
		
		$UI/WaitingPopup.show()
		$UI/WaitingPopup/AnimationPlayer.play("waiting")
		
func _on_host_button_pressed() -> void:
	if Steam.steamInit(480, true) == false:
		Global.print_error.emit("Steam must be running")
	else:
		$UI/LobbyScreen.hide()
		$GameElements.show()
		NetworkMaster.host_lobby()

func _on_multiplayer_spawner_spawned(node: Node) -> void:
	if node is StaticBody2D:
		initialize_player(node)


func _on_line_edit_text_changed(new_text: String) -> void:
	$UI/LobbyScreen/ColorRect/Panel/VBoxContainer/JoinButton.disabled = new_text.length() == 0

func _on_join_button_pressed() -> void:
	_join_button_pressed_.emit($UI/LobbyScreen/ColorRect/Panel/VBoxContainer/LineEdit.text.to_int())

func _on_player_joined() -> void:
	$UI/LobbyScreen.hide()
	$GameElements.show()
