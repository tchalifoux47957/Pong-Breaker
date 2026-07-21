extends Node
class_name GameMaster

const BRICK_QTY: int = 8
@onready var left_brick_container: Node2D = $LeftBrickContainer
@onready var right_brick_container: Node2D = $RightBrickContainer
@onready var game_over_screen: Control = $"../UI/GameOverScreen"

@onready var score_1: Label = $"../GameElements/ScoreContainer/Score1"
@onready var score_2: Label = $"../GameElements/ScoreContainer/Score2"
@onready var reset_timer: Timer = $Reset

var ball: Ball = null
var score:= [0,0] # [Player1, Player2]
var resetBricks: bool = false
var scoreLimit: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../UI/GameOverScreen"._rematch_requested.connect(reset_match)
	left_brick_container.set_position(Vector2(16 ,left_brick_container.position.y))
	right_brick_container.set_position(Vector2(560, right_brick_container.position.y))
	left_brick_container.generate_bricks(BRICK_QTY)
	right_brick_container.generate_bricks(BRICK_QTY)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_reset_timeout() -> void:
	if Global.isGamePaused == false:
		if resetBricks:
			for i in left_brick_container.get_children(): i.queue_free()
			for i in right_brick_container.get_children(): i.queue_free()
			left_brick_container.generate_bricks(BRICK_QTY)
			right_brick_container.generate_bricks(BRICK_QTY)
			resetBricks = false
		ball.new_ball()
		

func _on_goal_left_body_entered(body: Node2D) -> void:
	score[1] += 1
	score_2.set_text(str(score[1]))
	win_check()
	resetBricks = true
	reset_timer.start()
	

func _on_goal_right_body_entered(body: Node2D) -> void:
	score[0] += 1
	score_1.set_text(str(score[0]))
	if !win_check():
		resetBricks = true
		reset_timer.start()
	
func reset_match() -> void:
	score[0] = 0; score[1] = 0
	score_1.set_text(str(0)); score_2.set_text(str(0))
	$"../UI/PauseMenu".canPause = true
	if !win_check():
		resetBricks = true
		reset_timer.start()
		
	
	
func win_check() -> bool:
	if score[0] == scoreLimit:
		game_over_screen.show_win(1)
		reset_timer.stop()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$"../UI/PauseMenu".canPause = false
		return true
	elif score[1] == scoreLimit:
		game_over_screen.show_win(2)
		reset_timer.stop()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$"../UI/PauseMenu".canPause = false
		return true
	else:
		return false
