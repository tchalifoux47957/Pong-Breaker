extends Node

signal print_error(errorString: String)

#User settings
var resolution: int = 1080
var sfx_vol: int = 100
var bgm_vol: int = 100


var isGamePaused: bool = false


func set_sfx_vol(newVol: float) -> void:
	if sfx_vol != newVol:
		sfx_vol = newVol
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), newVol)
	
func set_bgm_vol(newVol: float) -> void:
	if bgm_vol != newVol:
		bgm_vol = newVol
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), newVol)
