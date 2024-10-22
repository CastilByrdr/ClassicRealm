extends CharacterBody2D

class_name Player

signal health_changed
signal health_depleted
var maxHealth=100
var health=100
var is_slow: bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sound_animation_player: AnimationPlayer = $SoundAnimationPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var slow_timer: Timer = $SlowTimer
func _ready():
	$SlowNotif.hide()
	
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
	if is_slow==true:
		velocity=velocity/2
	move_and_slide()

func take_damage():
	health-=20
	health_changed.emit()
	sound_animation_player.play("wizard_hit")
	if health<=0:
			sound_animation_player.play("wizard_death")
			health_depleted.emit()
			get_tree().change_scene_to_file("res://scenes/gameOver.tscn")

func slow():
	sound_animation_player.play("wizard_hit")
	animation_player.play("slowed")
	is_slow=true
	slow_timer.start()
	
func _on_slow_timer_timeout() -> void:
	is_slow=false
	animation_player.play("unslowed")
