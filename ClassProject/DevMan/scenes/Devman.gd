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
        $Sprite.flip_h = true
        $Sprite.play("walk")
    else:
        $Sprite.play("idle")
        
    if not is_on_floor():
        $Sprite.play("air")
    
    
    velocity.y = velocity.y + GRAVITY
    
    if Input.is_action_just_pressed("jump") and is_on_floor():
        print_debug("jumping")
        velocity.y = JUMPFORCE
    if Input.is_action_just_pressed("ui_cancel"):
        #get_tree().change_scene("res://LevelSelect/LevelSelect1.tscn")
        get_tree().change_scene("res://Credits/GodotCredits.tscn")
    
    velocity = move_and_slide(velocity,Vector2.UP)

    velocity.x = lerp(velocity.x,0,0.2)
