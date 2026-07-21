extends StaticBody2D
class_name Player

const PADDLE_SPEED: int = 500

var win_height: int
var p_height: int

var mouse_input: Vector2 = Vector2(0,0)
var sensitivity: float = 0.1
# Called when the node enters the scene tree for the first time.

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	
	
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	win_height = get_viewport_rect().size.y
	p_height = $Sprite2D.get_rect().size.y
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_input = event.relative.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!is_multiplayer_authority() && NetworkMaster.singleplayer == false) || Global.isGamePaused == true:
		return

	if Input.is_action_pressed("up"):
		position.y -= PADDLE_SPEED * delta
	elif Input.is_action_pressed("down"):
		position.y += PADDLE_SPEED * delta
		
	if mouse_input.length() > 0.5:
		
		position.y += (Input.get_last_mouse_velocity().y * sensitivity) * delta
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
