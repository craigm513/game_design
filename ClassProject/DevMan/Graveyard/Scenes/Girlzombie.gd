extends KinematicBody2D

const GRAVITY = 10
const SPEED = 50
const FLOOR = Vector2(0,-1)
var direction = 1
var is_dead = false

var velocity = Vector2()

var ZombieDeathSoundEffect1 = "res://Audio/Sound Effects/BrainsSoundEffect1.mp3";
var ZombieDeathSoundEffect2 = "res://Audio/Sound Effects/BrainsSoundEffect2.mp3";
var ZombieDeathSoundEffect3 = "res://Audio/Sound Effects/ZombieMoanSoundEffect1.mp3";
var ZombieDeathSoundEffect4 = "res://Audio/Sound Effects/ZombieMoanSoundEffect2.mp3";

var SoundEffectArray = [ZombieDeathSoundEffect1,ZombieDeathSoundEffect2,ZombieDeathSoundEffect3,ZombieDeathSoundEffect4];

onready var audioStream = get_parent().get_node("Audio/SoundEffect/EnemyAudio");

func _ready():
	pass # Replace with function body.

func dead():
	audioStream.stream = load(SoundEffectArray[randi() % 4]);
	audioStream.play();
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.disabled = true
	$Timer.start()
func _physics_process(delta):
	if is_dead == false:
		velocity.x = SPEED * direction
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
		
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity,FLOOR)
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
	if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "PLAYER" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()
	


func _on_Timer_timeout():
	queue_free()
