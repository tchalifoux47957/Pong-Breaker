extends Node
class_name GameMaster

@onready var score_1: Label = $"../GameElements/ScoreContainer/Score1"
@onready var score_2: Label = $"../GameElements/ScoreContainer/Score2"
@onready var reset_timer: Timer = $Reset

var ball: Ball = null
var score:= [0,0] # [Player1, Player2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_reset_timeout() -> void:
	ball.new_ball()


func _on_goal_left_body_entered(body: Node2D) -> void:
	score[1] += 1
	score_2.set_text(str(score[1]))
	reset_timer.start()

func _on_goal_right_body_entered(body: Node2D) -> void:
	score[0] += 1
	score_1.set_text(str(score[0]))
	reset_timer.start()
