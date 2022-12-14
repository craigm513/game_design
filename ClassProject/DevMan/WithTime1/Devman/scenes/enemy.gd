extends KinematicBody2D

var speed = 150
#change back to 225 speed
var velocity = Vector2()
export var direction = -1
export var detects_cliffs = true

onready var audioStream = get_parent().get_parent().get_node("Audio/SoundEffect/AudioStreamPlayer");
var EnemyDeathSoundEffect = "res://Audio/Sound Effects/EnemyDeathSoundEffect.wav";

func _ready():
	
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs
	
func _physics_process(delta):
	
	if is_on_wall() or not $floor_checker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	velocity.y += 20
	
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity,Vector2.UP)


func _on_top_checker_body_entered(body):
	audioStream.stream = load(EnemyDeathSoundEffect);
	audioStream.play();	
	$AnimatedSprite.play("squashed") 
	speed = 0
	set_collision_layer_bit(4,false)
	set_collision_mask_bit(0,false)
	$top_checker.set_collision_layer_bit(4,false)
	$top_checker.set_collision_mask_bit(0,false)
	$sides_checker.set_collision_layer_bit(4,false)
	$sides_checker.set_collision_mask_bit(0,false)
	$Timer.start()
	body.bounce()

func _on_sides_checker_body_entered(body):
	if body.get_collision_layer() == 1:
		body.ouch(position.x)
	elif body.get_collision_layer() == 32:
		audioStream.stream = load(EnemyDeathSoundEffect)
		audioStream.play();	
		body.queue_free()
		queue_free()

func _on_Timer_timeout():
	queue_free()
