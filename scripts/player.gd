extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down") 
	if Input.is_action_pressed("down"):
		animated_sprite_2d.play("down")
	if Input.is_action_pressed("up"):
		animated_sprite_2d.play("up")
	if Input.is_action_pressed("right"):
		animated_sprite_2d.play("right")
	if Input.is_action_pressed("left"):
		animated_sprite_2d.play("left")
	velocity = direction * 100
	move_and_slide()
