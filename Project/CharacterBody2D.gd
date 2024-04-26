extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

@onready var JumpLabel = get_node('/root/Game/JumpLabel')

var rng = RandomNumberGenerator.new()
var rand
var Taunting = false
var ScreenSize
@export var Jumps = 2
var JumpCount = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	
	ScreenSize = get_viewport_rect().size
	
func anim(type):
	if Taunting == true:
		$AnimatedSprite2D.play(str("taunt", rand))
	else:	
		if Jumps < 2:
			$AnimatedSprite2D.play("jump")
		else:
			if type == "idle":
				$AnimatedSprite2D.play("idle")
			elif type == "walk":
				$AnimatedSprite2D.play("walk")
	


func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
		anim("jump")
		$LandSound.play(0)
		
	if is_on_floor():
		Jumps = 2


	if Input.is_action_just_pressed("Move_Jump") and Jumps != 0:
		velocity.y = JUMP_VELOCITY
		$JumpSound.play(0)
		Jumps -= 1
		JumpCount += 1
		JumpLabel.text = str("[center]",JumpCount, " Jumps[/center]")
		
	if Input.is_action_just_pressed("Taunt"):
		if Taunting == false:
			Taunting = true
			rand = rng.randi_range(1,2)
			anim("taunt")
			$Taunt.pitch_scale = rng.randf_range(0.90,1.10)
			$Taunt.play(0)
			await get_tree().create_timer(0.5).timeout
			Taunting = false

	var direction = Input.get_axis("Move_Left", "Move_Right")
	if direction:
		velocity.x = direction * SPEED
		anim("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim("idle")


	position = position.clamp(Vector2(0,0), ScreenSize)
	move_and_slide()
