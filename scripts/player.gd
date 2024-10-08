extends CharacterBody2D

signal health_depleted
var health=100
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down") 
	if Input.is_action_pressed("down"):
		animated_sprite_2d.play("down")
	elif Input.is_action_pressed("up"):
		animated_sprite_2d.play("up")
	elif Input.is_action_pressed("right"):
		animated_sprite_2d.play("right")
	elif Input.is_action_pressed("left"):
		animated_sprite_2d.play("left")
	velocity = direction * 75
	move_and_slide()
	
	const DAMAGE_RATE=10
	var overlapping_mobs=%HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size()>0:
		animation_player.play("wizard_hit")
		health-=DAMAGE_RATE*overlapping_mobs.size()*delta
	if health<=0:
		animation_player.play("wizard_death")
		health_depleted.emit()
