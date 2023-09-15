extends Button

@onready var ButtonAudio:AudioStreamPlayer = $Audio_Button



var Audio_Mousein = preload("res://Tool_MainScene/Audios/Button_mouseslide.wav")
var Audio_ButtonPress = preload("res://Tool_MainScene/Audios/button_Pressed.mp3")
# Called when the node enters the scene tree for the first time.
func _ready():
	pivot_offset = size/2
	# 从中心缩放
	pass # Replace with function body.

func _on_mouse_entered():
	ButtonAudio.stream = Audio_Mousein
	ButtonAudio.play()
	var Butween = create_tween()
	Butween.tween_property(self, "scale",Vector2(1.2,1.2),0.1)
	pass # Replace with function body.
	
func _on_mouse_exited():
	var Butween = create_tween()
	Butween.tween_property(self, "scale",Vector2(1,1),0.2)
	pass # Replace with function body.

func _on_button_down():
	ButtonAudio.stream = Audio_ButtonPress
	ButtonAudio.play()
	pass # Replace with function body.



