extends Control

@export var Texturect_Model:PackedScene = preload("res://Scenes/TextureRectModel.tscn")
@export var CoinTexture:Resource = preload("res://Assets/coin.png")
@export var SisterTexture:Resource = preload("res://Assets/girl1.png")


@onready var CoinSlot:HBoxContainer = $VBoxContainer/Coins/Coinslot
@onready var CoinLabel:Label = $VBoxContainer/Coins/Label

@onready var SisterSlot:HBoxContainer = $VBoxContainer/Sisters/SisSlot
@onready var SisterLabel:Label = $VBoxContainer/Sisters/Label

@onready var ScoreLabel:Label = $VBoxContainer/Score/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	UpdateSlotWithModel(CoinSlot, Texturect_Model, GlobalVars.NowCoins)
	UpdateSlotWithModel(SisterSlot, Texturect_Model, GlobalVars.AwakeningSisters)
	UpdateSlotTexture()
	UpdateLabels()
	JudgeWin()
	pass

func UpdateSlotWithModel(Slot:Container, Model:PackedScene, Amount:int):
	var ChildNeedAdd = Amount - Slot.get_child_count()
	if ChildNeedAdd > 0:
		#需要增加子节点
		for x in range(ChildNeedAdd):
			var c = Model.instantiate()
			Slot.add_child(c)
	else:
		#需要减少子节点
		for x in range(abs(ChildNeedAdd)):
			Slot.get_child(-1).queue_free()
	
func UpdateSlotTexture():
	for coin in CoinSlot.get_children():
		coin.texture = CoinTexture
	for sis in SisterSlot.get_children():
		sis.texture = SisterTexture
	
	
func UpdateLabels():
	CoinLabel.text = "花西币 "+str(GlobalVars.NowCoins)+" / "+str(GlobalVars.MaxCoins)
	SisterLabel.text = "清醒美眉 "+str(GlobalVars.AwakeningSisters)+" / "+str(GlobalVars.TotalSisters)
	ScoreLabel.text = "总分  "+ str(GlobalVars.Score)


func JudgeWin():
	var HighScoreListPath:String = "res://HighscoreList/Scenes/high_score_list.tscn"
	if GlobalVars.AwakeningSisters >= GlobalVars.TotalSisters:
		get_tree().change_scene_to_packed(load(HighScoreListPath))
