extends Control
# 在游戏中使用UpdateHSList(newInfo:Dictionary）来添加分数信息到排行榜，
# 信息为字典格式，具体格式如下
# infotype ==> {"name":"mane", "score": "556", "date": "2023.5.6"}

# 使用下面的语句将整合好的信息输送到场景中：
#GlobalVars.ScoreInfo["name"] = "Unknow"
#GlobalVars.ScoreInfo["score"] = "%.2f"%[GlobalVars.ScoreThisTime]
#GlobalVars.ScoreInfo["date"] = Time.get_date_string_from_system()


var score_file_path = "user://save/"
var score_file_name = "HSL.tres"
var HSL = []
var HslFromFile = HSLData.new()

var MaxHS_Len = 10
# save Hightest 10 score

# Called when the node enters the scene tree for the first time.
func _ready():
	verify_save_directory(score_file_path)
	LoadFromFile()
	UpdateHSList(GlobalVars.ScoreInfo)
	pass # Replace with function body.

func verify_save_directory(path:String):
	DirAccess.make_dir_absolute(path)
	print("path")
	print(path)

func SaveToFile():
	# Save HSL to file; it is a list of dictionary
	HslFromFile.HSL = HSL
	ResourceSaver.save(HslFromFile,score_file_path+score_file_name)
	pass
	
func LoadFromFile():
	# load HSL from file; it is a list of dictionary
	if FileAccess.file_exists(score_file_path+score_file_name):
		HslFromFile = ResourceLoader.load(score_file_path+score_file_name).duplicate(true)
		HSL = HslFromFile.HSL
		
func compare_Score(a, b):
	if int(a["score"]) > int(b["score"]):
		return true
	else:
		return false
	
	
func RenderToScreen():
	# delete all list info on screen; and refresh them from CurrentList
	var InfoItem = preload("res://HighscoreList/Scenes/score_info_item.tscn")
	for olditem in $VBoxContainer.get_children():
		olditem.queue_free()
	for info in HSL:
		var item = InfoItem.instantiate()
		$VBoxContainer.add_child(item)
		item.Load_From_Info(info)
		

func UpdateHSList(newInfo:Dictionary):
	# add NewInfo to the list, and sort it again
	# outsidescript will only call this func
	# infotype ==> {"name":"mane", "score": "556", "date": "2023.5.6"}
	if newInfo:
		HSL.append(newInfo)
	HSL.sort_custom(compare_Score)
	HSL = HSL.slice(0,MaxHS_Len)
	RenderToScreen()
	SaveToFile()
	
func _on_button_return_mouse_entered():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($Button_Return, "scale", Vector2(1.2,1.2), 0.2)


func _on_button_return_mouse_exited():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($Button_Return, "scale", Vector2(1,1), 0.2)


func _on_button_return_pressed():
	get_tree().change_scene_to_file("res://Tool_MainScene/scenes/MainMenu.tscn")
	pass # Replace with function body.
	
# ----------------------------DEBUG FUNC----------------------------
func AddRandomScore():
	#debug, add info to HSL
	var scoreInfo = {}
	scoreInfo["name"] = "suiji"+str(randi_range(500,600))
	scoreInfo["score"] = str(randi_range(5,30000))
	scoreInfo["date"] = str(randi_range(800,900))
	print(scoreInfo)
	UpdateHSList(scoreInfo)
	

func _on_button_pressed():
	AddRandomScore()
	pass # Replace with function body.


func _on_button_2_pressed():
	HSL = []
	SaveToFile()
	pass # Replace with function body.
