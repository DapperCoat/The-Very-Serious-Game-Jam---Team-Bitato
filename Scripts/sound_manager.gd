extends Node

var sound_list: Array[AudioStreamPlayer] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		sound_list.append(child)
	print(sound_list)

func play_sound(sound_location: int) -> void:
	sound_list[sound_location].play()
