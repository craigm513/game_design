extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 180
const GRAVITY = 35
const JUMPFORCE = -1100

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
