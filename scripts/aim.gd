extends Area2D

var player
@onready var attack_timer: Timer = $AttackTimer
func _ready():
	player = get_node("/root/Game/Player")
	
func _physics_process(delta: float) -> void:
	if player:
		var player_position = player.global_position
		var current_position = global_position
		var direction = player_position - current_position
		rotation = direction.angle()

func shoot():
	const SLOW = preload("res://scenes/slow.tscn")
	const SLASH = preload("res://scenes/slash.tscn")
	var new_slow = SLOW.instantiate()
	var new_slash = SLASH.instantiate()
	var new_slash2 = SLASH.instantiate()
	var new_slash3 = SLASH.instantiate()
	new_slow.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position 
	new_slash.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position 
	new_slash2.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
	new_slash3.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
	new_slow.rotation = self.rotation
	new_slash.rotation = self.rotation
	new_slash2.rotation = self.rotation+45
	new_slash3.rotation = self.rotation-45
	$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slow) 
	$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slash) 
	$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slash2) 
	$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slash3) 

func _on_attack_timer_timeout() -> void:
	shoot()
