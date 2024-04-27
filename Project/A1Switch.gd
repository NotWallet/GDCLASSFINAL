extends Area2D

var Act = false

var SwitchOn = Image.load_from_file("res://switchon.png")
var newtex = ImageTexture.create_from_image(SwitchOn)
@onready var Player = get_node("/root/Game/Player/")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "Player" and Act == false:
		body.Touching = "A1Switch"
		pass


func Activate():
	if Act == false:
		Act = true
		$Sprite.texture = newtex
		$A1Tiles.set_layer_enabled(0, true)
		Player.startcamera()
		$Tuto.queue_free()
		$JumpPickup.visible = true
		
		

func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "Player":
		body.Touching = "None"
	pass # Replace with function body.
