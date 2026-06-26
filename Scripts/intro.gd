extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalMusicPlayer.play()

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game_scene.tscn")
