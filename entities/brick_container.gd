extends Node2D

const BRICK = preload("uid://clhx8h7vvnos1")


func generate_bricks(count: int) -> void:
	var pos: Vector2 = position
	for i in count:
		var newBrick: StaticBody2D = BRICK.instantiate()
		add_child(newBrick)
		newBrick.position = Vector2(pos)
		pos.y += 74
