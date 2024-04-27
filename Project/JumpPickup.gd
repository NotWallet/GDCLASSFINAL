extends Area2D

@onready var Player = get_node("/root/Game/Player/")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		Player.MaxJumps = 2
		self.visible = false
		
	pass # Replace with function body.
