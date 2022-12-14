extends Area2D

const SPEED = 1000
var velocity = Vector2()
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
func _physics_process(delta):
	velocity.x = SPEED * delta *direction
	translate(velocity)
	$AnimatedSprite.play("shoot")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		body.dead()
	if "boyzombie" in body.name:
		body.dead()
	if "Girlzombie" in body.name:
		body.dead()
	queue_free()
