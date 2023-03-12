extends KinematicBody2D

var state

var xmove = 0
var ymove = 0

enum {
	neutral,
	scared,
	sleeping,
	walk
}

var mouseinside = false

#cat's stats
var attractiveness = round(rand_range(1, 5))
var speed = round(rand_range(1, 5))
var love = round(rand_range(1, 5))
var quietness = round(rand_range(0, 3))

var catname = "placeholder"
var parents = "..."

var color = Color(0.0, 1.0, 0.0)

func _ready():
	randomize() 

func _physics_process(delta):
	
	if $Timer2.time_left == 0:
		$CatName.text = ""
	
	#cat's stats
	$CanvasLayer/AcceptDialog.dialog_text = ("Name: " + String(catname) + "\n\n" + "Attractiveness: " + String(attractiveness) + "\n" + "Speed: " + String(speed) + "\n" + "Love: " + String(love) + "\n" + "Quiet: " + String(quietness) + "\n" + "Parents: " + String(parents))
	
	#yeah... idk how to comments this
	if xmove > 0 or ymove > 0 or xmove < 0 or ymove < 0:
		state = walk
	else:
		state = neutral
		
	if xmove < 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	
	$AnimatedSprite.modulate = color
	
	match state:
		neutral:
			netrual_state()
		scared:
			scared_state()
		sleeping:
			sleeping_state()
		walk:
			walk_state(delta)
			
		
func netrual_state():
	$AnimatedSprite.play("neutral")
	
func scared_state():
	$AnimatedSprite.play("scared")
	
func sleeping_state():
	$AnimatedSprite.play("sleeping")
	
func walk_state(delta):
	$AnimatedSprite.play("walk")
	move_and_slide(Vector2(xmove, ymove))


func _on_Timer_timeout():
	#random cat movements lol
	#shit code but i was having fun so
	if round(rand_range(1, 3)) > 1:
		xmove = round(rand_range(-5, 5) * speed)
		ymove = round(rand_range(-5, 5) * speed)
	else:
		xmove = 0
		ymove = 0

func _on_MeowTimer_timeout():
	#meow
	if round(rand_range(1, 5 + quietness)) == 5 + quietness:
		$CatName.text = "meow"
		$Timer2.start()


func _on_Button_pressed():
	$CanvasLayer/AcceptDialog.popup()



func _on_Buttown_pressed():
	#death
	queue_free()
