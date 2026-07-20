extends Node
class_name GameMaster

const BRICK_QTY: int = 8
@onready var left_brick_container: Node2D = $LeftBrickContainer
@onready var right_brick_container: Node2D = $RightBrickContainer

@onready var score_1: Label = $"../GameElements/ScoreContainer/Score1"
@onready var score_2: Label = $"../GameElements/ScoreContainer/Score2"
@onready var reset_timer: Timer = $Reset

var ball: Ball = null
var score:= [0,0] # [Player1, Player2]
var resetGame: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	left_brick_container.set_position(Vector2(16 ,left_brick_container.position.y))
	right_brick_container.set_position(Vector2(560, right_brick_container.position.y))
	left_brick_container.generate_bricks(BRICK_QTY)
	right_brick_container.generate_bricks(BRICK_QTY)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_reset_timeout() -> void:
	if resetGame:
		for i in left_brick_container.get_children(): i.queue_free()
		for i in right_brick_container.get_children(): i.queue_free()
		left_brick_container.generate_bricks(BRICK_QTY)
		right_brick_container.generate_bricks(BRICK_QTY)
		resetGame = false
	ball.new_ball()
	

func _on_goal_left_body_entered(body: Node2D) -> void:
	score[1] += 1
	score_2.set_text(str(score[1]))
	resetGame = true
	reset_timer.start()
	

func _on_goal_right_body_entered(body: Node2D) -> void:
	score[0] += 1
	score_1.set_text(str(score[0]))
	resetGame = true
	reset_timer.start()


	
