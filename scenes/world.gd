extends Node2D

const PADDLE = preload("uid://dqojax6xtqdwu")
const BALL = preload("uid://dqgio6jn88ad2")

@onready var game_master: GameMaster = $GameMaster

var players: Array[StaticBody2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
		$UI.hide()

func initialize_player(player: StaticBody2D, isHost: bool = false) -> void:
	if isHost:
		player.position = Vector2( 16, get_viewport_rect().size.y / 2)
	else:
		player.position = Vector2(get_viewport_rect().size.x - 16, get_viewport_rect().size.y / 2 )
	players.append(player)
	
	if players.size() == 2:
		var ball := BALL.instantiate() as RigidBody2D
		add_child(ball)
		$GameMaster.ball = ball
		ball.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
		$GameMaster/Reset.start()

func _on_button_pressed() -> void:
	$UI.hide()
	$GameElements.show()
	NetworkMaster.host_lobby()

func _on_multiplayer_spawner_spawned(node: Node) -> void:
	if node is StaticBody2D:
		initialize_player(node)
