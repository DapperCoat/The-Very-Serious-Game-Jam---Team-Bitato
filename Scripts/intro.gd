extends Node2D
@onready var sound_manager: Node = $SoundManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalMusicPlayer.play_level_music()

func _on_start_game_pressed() -> void:
	sound_manager.play_sound(3)
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/game_scene.tscn")
