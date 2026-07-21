extends Node

signal host_created()
signal player_joined
signal player_left
const LOBBY_TYPE := Steam.LobbyType.LOBBY_TYPE_FRIENDS_ONLY
const MAX_PLAYERS: int = 2

var singleplayer: bool = false
var peer: SteamMultiplayerPeer
var isJoining: bool = false
var inGame: bool = false
var lobbyID: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Steam initialized: ", Steam.steamInit(480, true))

	Steam.initRelayNetworkAccess()
	Steam.lobby_created.connect(_on_lobby_created)
	Steam.lobby_joined.connect(_on_lobby_joined)
	Steam.join_requested.connect(_on_join_requested)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Steam.run_callbacks()

func host_lobby() -> void:
	#Emits lobby_created and lobby_joined signals
	Steam.createLobby(LOBBY_TYPE, MAX_PLAYERS)
	
#After creating local lobby
func _on_lobby_created(connect: int, newLobbyID: int) -> void:
	if connect == Steam.RESULT_OK:
		self.lobbyID = newLobbyID
		peer = SteamMultiplayerPeer.new()
		peer.server_relay = true
		peer.create_host()
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_disconnected.connect(_remove_player)
		host_created.emit()
		print(lobbyID)
	
#When joining a lobby (after creation or joining other)
func _on_lobby_joined(lobbyID: int, permissions: int, locked: bool, response: int) -> void:
	if response == Steam.CHAT_ROOM_ENTER_RESPONSE_SUCCESS:
		#If we create lobby, don't create new client peer
		if Steam.getLobbyOwner(lobbyID) == Steam.getSteamID():
			return
		peer = SteamMultiplayerPeer.new()
		peer.server_relay = true
		peer.create_client(Steam.getLobbyOwner(lobbyID))
		multiplayer.multiplayer_peer = peer
		player_joined.emit()
		inGame = true
		
	
#When joining via Steam overlay
func _on_join_requested(lobbyID: int, SteamID: int) -> void:
	get_tree().change_scene_to_file("res://scenes/mp_world.tscn")
	Steam.joinLobby(lobbyID)

func join_lobby(newlobbyID: int) -> void:
	isJoining = true
	Steam.joinLobby(newlobbyID)


func _remove_player(id: int):
	print("player left")
	player_left.emit()
	if !self.has_node(str(id)):
		return
		
	self.get_node(str(id)).queue_free()
