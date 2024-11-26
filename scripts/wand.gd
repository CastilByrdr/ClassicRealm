extends Area2D

var can_shoot: bool = true 
var player
@onready var shoot_timer: Timer = $ShootTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	player = get_node("/root/Game/Player")
	
func _physics_process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	var direction = mouse_position - global_position
	if player.is_drunk:
		# Randomize rotation when the player is drunk
		rotation = randf_range(0, 2 * PI)  # Random angle between 0 and 2 * PI
	else:
		# Otherwise, rotate towards the mouse position
		rotation = direction.angle()
	if Input.is_action_pressed("shoot"):
		shoot() 
	
func shoot():
	if can_shoot:
		const BULLET = preload("res://scenes/bullet.tscn")
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = $Pivot/Weapon/ShootingPoint.global_position 
		new_bullet.rotation = self.rotation
		$Pivot/Weapon/ShootingPoint.add_child(new_bullet)  
		animation_player.play("shoot")
		can_shoot = false 
		shoot_timer.start()
		
func _on_shoot_timer_timeout() -> void:
	can_shoot = true
