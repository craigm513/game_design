extends KinematicBody2D

var velocity = Vector2(0,0)
var coins = 0
const SPEED = 180
const GRAVITY = 35
const JUMPFORCE = -1100

var JumpSoundEffect = "res://Audio/Sound Effects/JumpSoundEffect.mp3";
var FallSoundEffect = "res://Audio/Sound Effects/FallSoundEffect.wav";
onready var audioStream = get_parent().get_node("Audio/SoundEffect/AudioStreamPlayer");

func _physics_process(_delta):

	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	else:
		$Sprite.play("idle")

	if not is_on_floor():
		$Sprite.play("air")


	velocity.y = velocity.y + GRAVITY

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
		audioStream.stream = load(JumpSoundEffect);
		audioStream.play();


	velocity = move_and_slide(velocity,Vector2.UP)

	velocity.x = lerp(velocity.x,0,0.2)

	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://LevelSelect/LevelSelect1.tscn")


func _on_fallZone_body_entered(body):
	get_tree().change_scene("res://WithTime1/Devman/scenes/withTime.tscn")



=======
	audioStream.stream = load(FallSoundEffect);
	audioStream.play();
	yield(get_tree().create_timer(1.0), "timeout");
	get_tree().change_scene("res://WithTime1/Devman/scenes/withTime.tscn");
>>>>>>> main

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
