extends CanvasLayer

# Function to start the fade-in animation
func start_fade():
	$AnimationPlayer.play("fade_in")
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_fade_complete"))

# Function to call when the fade is complete
func _on_fade_complete(anim_name: String, callback: Callable):
	if anim_name == "fade_in":
		callback.call()
