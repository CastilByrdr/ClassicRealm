extends CharacterBody2D

class_name Oryx

signal health_changed
var maxHealth=500
var health=500
var player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var aim = $Aim
func _ready():
	player = get_node("/root/Game/Player")

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	if health>maxHealth/2:
		velocity = direction * 25
	else:
		velocity = direction * 0
	move_and_slide()

func take_damage():
	health-=10
	health_changed.emit()
	animation_player.play("oryx_hit")
	if health<=0:
		animation_player.play("oryx_death")
		$TextureProgressBar.queue_free()
		aim.queue_free()
		animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))
		


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "oryx_death":
		get_tree().change_scene_to_file("res://scenes/win.tscn")
