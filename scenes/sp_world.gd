extends Node2D
const BALL = preload("uid://dqgio6jn88ad2")
const PADDLE = preload("uid://dqojax6xtqdwu")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ball := BALL.instantiate() as RigidBody2D
	add_child(ball)
	$GameMaster.ball = ball
	ball.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
	$GameMaster/Reset.start()
	
	var player := PADDLE.instantiate()

	player.position = Vector2( 64, get_viewport_rect().size.y / 2)

	add_child(player)
	
	
	
	var cpu := PADDLE.instantiate()
	var cpu_script = load("res://entities/cpu.gd")
	cpu.set_script(cpu_script)
	cpu.position = Vector2(get_viewport_rect().size.x - 64, get_viewport_rect().size.y / 2 )
	add_child(cpu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
