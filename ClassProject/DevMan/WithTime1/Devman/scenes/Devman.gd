extends KinematicBody2D


enum States {AIR = 1, FLOOR, LADDER, WALL}
var state = States.AIR
var velocity = Vector2(0,0)
var coins = 0
const SPEED = 135
const GRAVITY = 28
const JUMPFORCE = -900
const RUNSPEED = 200

var JumpSoundEffect = "res://Audio/Sound Effects/JumpSoundEffect.mp3";
var FallSoundEffect = "res://Audio/Sound Effects/FallSoundEffect.wav";
onready var audioStream = get_parent().get_node("Audio/SoundEffect/AudioStreamPlayer");

func _physics_process(_delta):
	print(velocity.x)
	match state:
		States.AIR:
			if is_on_floor():
				state = States.FLOOR
				continue
			# the line below loops while devman is in the air, fix it to make it run once
			$Sprite.play("air")
			if Input.is_action_pressed("right"):
				velocity.x = lerp(velocity.x,SPEED,0.1) if velocity.x < SPEED else lerp(velocity.x,SPEED,0.03)
				$Sprite.flip_h = false
			elif Input.is_action_pressed("left"):
				velocity.x = lerp(velocity.x,-SPEED,0.1) if velocity.x < SPEED else lerp(velocity.x,-SPEED,0.03)
				$Sprite.flip_h = true
			else:
				# might add $Sprite.play("idle") to show no movement 
				#if left or right isnt pressed while in air
				velocity.x = lerp(velocity.x,0,0.2)
			move_and_fall()
		States.FLOOR:
			if not is_on_floor():
				state = States.AIR
			if Input.is_action_pressed("right"):
				if Input.is_action_pressed("run"):
					velocity.x = lerp(velocity.x,RUNSPEED,0.1)
					$Sprite.set_speed_scale(1.5)
				else:
					velocity.x = lerp(velocity.x,SPEED,0.1)
					$Sprite.set_speed_scale(1.0)
				$Sprite.play("walk")
				$Sprite.flip_h = false
			elif Input.is_action_pressed("left"):
				if Input.is_action_pressed("run"):
					velocity.x = lerp(velocity.x,-RUNSPEED,0.1)
					$Sprite.set_speed_scale(1.5)
				else:
					velocity.x = lerp(velocity.x,-SPEED,0.1)
					$Sprite.set_speed_scale(1.0)
				$Sprite.play("walk")
				$Sprite.flip_h = true
			else:
				$Sprite.play("idle")
				velocity.x = lerp(velocity.x,0,0.2)
				
			if Input.is_action_just_pressed("jump"):
				velocity.y = JUMPFORCE
				audioStream.stream = load(JumpSoundEffect);
				audioStream.play();
				state = States.AIR
				
			move_and_fall()
		States.LADDER:
			pass
		States. WALL:
			pass

	#velocity.y = velocity.y + GRAVITY
	
	#velocity = move_and_slide(velocity,Vector2.UP)

	#velocity.x = lerp(velocity.x,0,0.2)
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://LevelSelect/LevelSelect1.tscn")

func move_and_fall():
	velocity.y = velocity.y + GRAVITY
	velocity = move_and_slide(velocity,Vector2.UP)

func _on_fallZone_body_entered(body):
	audioStream.stream = load(FallSoundEffect);
	audioStream.play();
	yield(get_tree().create_timer(1.0), "timeout");
	get_tree().change_scene("res://WithTime1/Devman/scenes/withTime.tscn");
	
func bounce():
	velocity.y = JUMPFORCE * 0.4
	
func ouch(var enemyposx):
	set_modulate(Color(1,0.3,0.3,0.3))
	velocity.y = JUMPFORCE * 0.5
	
	if position.x < enemyposx:
		velocity.x = -800
	elif position.x > enemyposx:
		velocity.x = 800
	
	Input.action_release("left")
	Input.action_release("right")
	
	$Timer.start()
		
		
	
	
	


func _on_Timer_timeout():
	get_tree().change_scene("res://WithTime1/Devman/scenes/withTime.tscn")
