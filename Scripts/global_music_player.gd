extends AudioStreamPlayer

# const level_music = preload("")

# Plays Level Music Globally
func _play_music(music: AudioStream, volume = -17.0):
	if stream == music:
		return
	else:
		stream = music
		volume_db = volume
		play()

func play_level_music():
	pass
	# _play_music(level_music)

func _on_finished() -> void:
	pass # Replace with function body.
	# _play_music(level_music)
