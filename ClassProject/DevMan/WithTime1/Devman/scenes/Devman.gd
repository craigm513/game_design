extends KinematicBody2D

export(String,FILE,"*.TSCN") var target_stage
enum States {AIR = 1, FLOOR, LADDER, WALL}
var state = States.AIR
var velocity = Vector2(0,0)
var coins = 0
const SPEED = 360
const GRAVITY = 34
const JUMPFORCE = -900
const RUNSPEED = 500
const FIREBALL = preload("res://WithTime1/Devman/scenes/Fireball.tscn")

var JumpSoundEffect = "res://Audio/Sound Effects/JumpSoundEffect.mp3";
var FallSoundEffect = "res://Audio/Sound Effects/FallSoundEffect.wav";
var FireballSoundEffect = "res://Audio/Sound Effects/FireballSoundEffect.mp3";
var LevelCompletedSoundEffect = "res://Audio/Sound Effects/Level1CompletedSoundEffect.mp3";
var DevmanHurtSoundEffect = "res://Audio/Sound Effects/DevmanHurtSoundEffect.wav";

onready var audioStream = get_parent().get_node("Audio/SoundEffect/AudioStreamPlayer");

func _physics_process(delta):
	match state:
		States.AIR:
			if is_on_floor():
				state = States.FLOOR
				continue
			$Sprite.play("air")
			if Input.is_action_pressed("right"):
				velocity.x = lerp(velocity.x,SPEED,0.1) if velocity.x < SPEED else lerp(velocity.x,SPEED,0.03)
				$Sprite.flip_h = false
			elif Input.is_action_pressed("left"):
				velocity.x = lerp(velocity.x,-SPEED,0.1) if velocity.x > -SPEED else lerp(velocity.x,-SPEED,0.03)
				$Sprite.flip_h = true
			else:
				velocity.x = lerp(velocity.x,0,0.2)
			move_and_fall()
			fire()
			
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
			fire()
		States.LADDER:
			pass
		States. WALL:
			pass
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://LevelSelect/LevelSelect1.tscn")

func fire():
	if Input.is_action_pressed("right"):
		if Input.is_action_just_pressed("fire"): 
			audioStream.stream = load(FireballSoundEffect);
			audioStream.play();
			var direction = 1 if not $Sprite.flip_h else -1
			var f = FIREBALL.instance()
			f.direction = direction
			get_parent().add_child(f)
			f.position.y = position.y - 25
			f.position.x = position.x + 45 * direction if not $Sprite.flip_h else position.x + 72 * direction
	if Input.is_action_pressed("left"):
		if Input.is_action_just_pressed("fire"): 
			audioStream.stream = load(FireballSoundEffect);
			audioStream.play();
			var direction = 1 if not $Sprite.flip_h else -1
			var f = FIREBALL.instance()
			f.direction = direction
			get_parent().add_child(f)
			f.position.y = position.y - 25
			f.position.x = position.x + 45 * direction if not $Sprite.flip_h else position.x + 72 * direction

func move_and_fall():
	velocity.y = velocity.y + GRAVITY
	velocity = move_and_slide(velocity,Vector2.UP)

func _on_fallZone_body_entered(body):
	audioStream.stream = load(FallSoundEffect);
	audioStream.play();
	yield(get_tree().create_timer(1.0), "timeout");
	get_tree().change_scene("res://WithTime1/Devman/scenes/withTime.tscn")

func bounce():
	velocity.y = JUMPFORCE * 0.4

func ouch(var enemyposx):
	audioStream.stream = load(DevmanHurtSoundEffect);
	audioStream.play();
	#set_modulate(Color(1,0.3,0.3,0.3))
	velocity.y = JUMPFORCE * 0.5

	if position.x < enemyposx:
		velocity.x = -800
	elif position.x > enemyposx:
		velocity.x = 800

	Input.action_release("left")
	Input.action_release("right")

	$Timer.start()

func _on_Timer_timeout():
	pass
	#get_tree().change_scene("res://WithTime1/Devman/scenes/withTime.tscn")

func _on_Door_body_entered(body):
	audioStream.stream = load(LevelCompletedSoundEffect);
	audioStream.play();
	yield(get_tree().create_timer(2.0), "timeout");
	get_tree().change_scene("res://Graveyard/Scenes/GraveyardGame.tscn")
