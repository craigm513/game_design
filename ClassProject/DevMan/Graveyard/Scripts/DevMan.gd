extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 180
const GRAVITY = 35
const JUMPFORCE = -1100
const FIREBALL = preload("res://Graveyard/Scenes/Fireball.tscn")
func _physics_process(_delta):
	
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
		$Sprite.play("standing")
		
	if not is_on_floor():
		$Sprite.play("air")
	
	velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	
	velocity = move_and_slide(velocity,Vector2.UP)

	velocity.x = lerp(velocity.x,0,0.2)
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://LevelSelect/LevelSelect1.tscn")
