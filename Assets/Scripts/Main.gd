extends Node2D

var cat = preload("res://Assets/Scenes/Cat.tscn")

var catcount = 0

func _physics_process(delta):
	#thing that listens every cat that is currently on the scene
	#love this code ngl
	if $Cats.get_children().size() != catcount:
		catcount = $Cats.get_children().size()
		$Camera2D/UI/CanvasLayer/OptionButton.clear()
		$Camera2D/UI/CanvasLayer/OptionButton2.clear()
		for i in $Cats.get_children():
			$Camera2D/UI/CanvasLayer/OptionButton.add_item(i.catname)
			$Camera2D/UI/CanvasLayer/OptionButton2.add_item(i.catname)

	

func _on_Button_pressed():
	randomize()
	#thing that prevents a cat having a empty name
	if $Camera2D/UI/CanvasLayer/TextEdit.text == "":
		return
	
	#spawns the cat
	var newcat = cat.instance()
	newcat.color = Color(rand_range(0.0, 1.0), rand_range(0.0, 1.0), rand_range(0.0, 1.0))
	newcat.position = Vector2(rand_range(15, 280), rand_range(15, 160))
	newcat.catname = $Camera2D/UI/CanvasLayer/TextEdit.text
	$Cats.add_child(newcat)


func _on_TextEdit_text_changed():
	#does so that TextEdit and TextEdit2 have max of 10 symbols
	if $Camera2D/UI/CanvasLayer/TextEdit.get_text().length() >= 10:
		$Camera2D/UI/CanvasLayer/TextEdit.readonly = true
	if $Camera2D/UI/CanvasLayer/TextEdit2.get_text().length() >= 10:
		$Camera2D/UI/CanvasLayer/TextEdit2.readonly = true
		
		
func _input(event):
	#read comment above
	if Input.is_action_just_pressed("backspace"):
		$Camera2D/UI/CanvasLayer/TextEdit.readonly = false
		$Camera2D/UI/CanvasLayer/TextEdit2.readonly = false

func _on_Button2_pressed():
	#you can breed cats, pretty shitty code
	if $Camera2D/UI/CanvasLayer/TextEdit2.text == "":
		return
	
	var firstcat = $Cats.get_child($Camera2D/UI/CanvasLayer/OptionButton2.selected)
	var secondcat = $Cats.get_child($Camera2D/UI/CanvasLayer/OptionButton.selected)
	
	if firstcat == null or secondcat == null:
		return
	
	var newcat = cat.instance()
	newcat.color = firstcat.color.linear_interpolate(secondcat.color, 0.5)
	newcat.speed = round((firstcat.speed + secondcat.speed) / 2)
	newcat.attractiveness = round((firstcat.attractiveness + secondcat.attractiveness) / 2)
	newcat.quietness = round((firstcat.quietness + secondcat.quietness) / 2)
	newcat.love = round((firstcat.love + secondcat.love) / 2)
	newcat.parents = (firstcat.catname + ", " + secondcat.catname)
	newcat.position = Vector2(rand_range(15, 280), rand_range(15, 160))
	newcat.catname = $Camera2D/UI/CanvasLayer/TextEdit2.text
	$Cats.add_child(newcat)

