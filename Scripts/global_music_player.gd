extends AudioStreamPlayer

const level_music = preload("res://Assets/SFX/Music/Industry3.wav")

# Plays Level Music Globally
func _play_music(music: AudioStream, volume = -12.0):
	if stream == music:
		return
	else:
		stream = music
		volume_db = volume
		play()

func play_level_music():
	_play_music(level_music)

func _on_finished() -> void:
	stream = null
	_play_music(level_music)
