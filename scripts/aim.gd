extends Area2D

var player
var oryx
var has_executed: bool = false
var can_shoot: bool = false
@onready var attack_timer: Timer = $AttackTimer
@onready var attack_timer2: Timer = $AttackTimer2
@onready var attack_timer3: Timer = $AttackTimer3

func _ready():
	player = get_node("/root/Game/Player")
	oryx = get_node("/root/Game/Oryx") as Oryx
	
func _physics_process(delta: float) -> void:
	if player:
		var player_position = player.global_position
		var current_position = global_position
		var direction = player_position - current_position
		rotation = direction.angle()

func shoot():
	const SLASH = preload("res://scenes/slash.tscn")
	const SLOW = preload("res://scenes/slow.tscn")
	var new_slash = SLASH.instantiate()
	var new_slash2 = SLASH.instantiate()
	var new_slash3 = SLASH.instantiate()
	new_slash.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position 
	new_slash2.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
	new_slash3.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
	new_slash.rotation = self.rotation
	new_slash2.rotation = self.rotation+45
	new_slash3.rotation = self.rotation-45
	$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slash) 
	$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slash2) 
	$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slash3) 
	if oryx.health>oryx.maxHealth/2:
		var new_slow = SLOW.instantiate()
		new_slow.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position 
		new_slow.rotation = self.rotation
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slow) 
	else:
		if not has_executed:
			attack_timer.queue_free()
			attack_timer2.start()
			has_executed=true

func _on_attack_timer_timeout() -> void:
	shoot()
