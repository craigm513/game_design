extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 180
const GRAVITY = 35
const JUMPFORCE = -1100

const FIREBALL = preload("res://Graveyard/Scenes/Blast.tscn")
var is_dead = false
func _physics_process(_delta):
	if is_dead == false:
		if Input.is_action_pressed("right"):
			velocity.x = SPEED
			$Sprite.play("walk")
			$Sprite.flip_h = false
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
			if Input.is_action_just_pressed("shoot"):
				var fireball = FIREBALL.instance()
				if sign($Position2D.position.x) == 1:
					fireball.set_fireball_direction(1)
				else:
					fireball.set_fireball_direction(-1)
				get_parent().add_child(fireball)
				fireball.position = $Position2D.global_position
				
		elif Input.is_action_pressed("left"):
			velocity.x = -SPEED
			$Sprite.play("walk")
			$Sprite.flip_h = true
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
			if Input.is_action_just_pressed("shoot"):
				var fireball = FIREBALL.instance()
				if sign($Position2D.position.x) == -1:
					fireball.set_fireball_direction(-1)
				else:
					fireball.set_fireball_direction(1)
				get_parent().add_child(fireball)
				fireball.position = $Position2D.global_position
		else:
			$Sprite.play("idle")
			
		if not is_on_floor():
			$Sprite.play("air")
		
		
		velocity.y = velocity.y + GRAVITY
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMPFORCE
		
		velocity = move_and_slide(velocity,Vector2.UP)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					dead()

	velocity.x = lerp(velocity.x,0,0.2)
func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$Sprite.play("dying")
	$CollisionShape2D.disabled = true
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Graveyard/Scenes/GraveyardGame.tscn")
