extends Control


@onready var sfx_spin_box: SpinBox = $Panel/MenuVBox/OptionsVBox/VolumeHbox/SliderSpinboxVBox/SFXVolumeHBox/SFXSliderHBox/SFXSpinBox
@onready var sfx_vol_slider: HSlider = $Panel/MenuVBox/OptionsVBox/VolumeHbox/SliderSpinboxVBox/SFXVolumeHBox/SFXSliderHBox/SFXVolSlider

@onready var bgm_spin_box: SpinBox = $Panel/MenuVBox/OptionsVBox/VolumeHbox/SliderSpinboxVBox/BGMVolumeHBox/BGMSliderHBox/BGMSpinBox
@onready var bgm_vol_slider: HSlider = $Panel/MenuVBox/OptionsVBox/VolumeHbox/SliderSpinboxVBox/BGMVolumeHBox/BGMSliderHBox/BGMVolSlider



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sfx_spin_box_value_changed(value: float) -> void:
	if Global.sfx_vol != value:
		Global.set_sfx_vol(value)
	sfx_vol_slider.set_value(value)


func _on_sfx_vol_slider_value_changed(value: float) -> void:
	if Global.sfx_vol != value:
		Global.set_sfx_vol(value)
	sfx_spin_box.set_value(value)
	



func _on_bgm_spin_box_value_changed(value: float) -> void:
	if Global.bgm_vol != value:
		Global.set_bgm_vol(value * .1)
	bgm_vol_slider.set_value(value)


func _on_bgm_vol_slider_value_changed(value: float) -> void:
	if Global.bgm_vol != value:
		Global.set_bgm_vol(value * .1)
	bgm_spin_box.set_value(value)


func _on_resolution_options_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
			if Global.resolution != 1080:
				Global.resolution = 1080 
		1:
			DisplayServer.window_set_size(Vector2i(1280, 720))
			if Global.resolution != 720:
				Global.resolution = 720 
		2:
			DisplayServer.window_set_size(Vector2i(640, 480))
			if Global.resolution != 480:
				Global.resolution = 480
