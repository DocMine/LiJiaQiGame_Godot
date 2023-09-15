extends Control

@onready var TexTRect:TextureRect = $TextureRect
var TeachImg:Array = [
	"res://Assets/TeachImgs/T1_2.jpg",
	"res://Assets/TeachImgs/T2_2.jpg",
	"res://Assets/TeachImgs/T3.jpg",
	"res://Assets/TeachImgs/T4.jpg"
]
var NowIndex:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if NowIndex < len(TeachImg):
		TexTRect.texture = load(TeachImg[NowIndex])
		NowIndex += 1
		if NowIndex == len(TeachImg):
			$Button.text = "都懂了！开始吧！"
	else:
		get_tree().change_scene_to_file("res://Scenes/BlowGame_Scene.tscn")
	pass # Replace with function body.
