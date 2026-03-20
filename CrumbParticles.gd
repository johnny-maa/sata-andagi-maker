extends CPUParticles2D

func _ready() -> void:
	emitting = true
	var tween = create_tween()
	tween.tween_interval(lifetime * 0.5)
	tween.tween_property(self, "modulate:a", 0.0, lifetime * 0.5)
	await tween.finished
	queue_free()
