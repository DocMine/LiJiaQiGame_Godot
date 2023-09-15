extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	finished.connect(loopPlay)
	pass # Replace with function body.
	
func loopPlay():
	play()
