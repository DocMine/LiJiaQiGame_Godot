extends Node2D

@onready var Audiobgm = $Audio_BGM
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_audio_bgm_finished():
	Audiobgm.play()
	pass # Replace with function body.


func _on_button_pressed():
	GlobalVars.Score = 0
	GlobalVars.NowCoins = 5
	GlobalVars.EnemyBornTime = 5
	GlobalVars.AwakeningSisters = 0
	get_tree().change_scene_to_file("res://Scenes/TeachScene.tscn")


func _on_button_4_pressed():
	get_tree().quit()
