extends Area2D

@export var speed = 300
var ScreenSize



# Called when the node enters the scene tree for the first time.
func _ready():
	ScreenSize = get_viewport_rect().size
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("Move_Right"):
		velocity.x += 1
	if Input.is_action_pressed("Move_Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Move_Crouch"):
		velocity.y += 1
	if Input.is_action_pressed("Move_Jump"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, ScreenSize)
