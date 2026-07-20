extends Node
class_name GameMaster

const BRICK = preload("uid://clhx8h7vvnos1")
const BRICK_QTY: int = 8

@onready var score_1: Label = $"../GameElements/ScoreContainer/Score1"
@onready var score_2: Label = $"../GameElements/ScoreContainer/Score2"
@onready var reset_timer: Timer = $Reset

var ball: Ball = null
var score:= [0,0] # [Player1, Player2]
var resetGame: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_bricks()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_reset_timeout() -> void:
	if resetGame:
		for i in $LeftBrickContainer.get_children(): i.queue_free()
		for i in $RightBrickContainer.get_children(): i.queue_free()
		generate_bricks()
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

func generate_bricks() -> void:
	var pos = $LeftBrickContainer.position.y
	for i in BRICK_QTY:
		var newBrick: StaticBody2D = BRICK.instantiate()
		$LeftBrickContainer.add_child(newBrick)
		newBrick.position = Vector2($LeftBrickContainer.position.x, pos)
		pos += 74
		
	pos = $RightBrickContainer.position.y
	for i in BRICK_QTY:
		var newBrick: StaticBody2D = BRICK.instantiate()
		$RightBrickContainer.add_child(newBrick)
		newBrick.position = Vector2($RightBrickContainer.position.x, pos)
		pos += 74
