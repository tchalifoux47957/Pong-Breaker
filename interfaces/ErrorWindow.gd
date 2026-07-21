extends PanelContainer

@onready var error_label: Label = $VBoxContainer/ErrorLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.print_error.connect(print_error)


func print_error(errorString: String) -> void:
	if Input.get_mouse_mode() == Input.MouseMode.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.show()
	error_label.text = "Error: " + errorString


func _on_button_pressed() -> void:
	self.hide()
