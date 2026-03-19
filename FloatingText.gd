extends Node2D

func _ready() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	
	# 上方向に移動
	var end_pos = position - Vector2(0, 50)
	tween.tween_property(self, "position", end_pos, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	
	# フェードアウト
	tween.tween_property(self, "modulate:a", 0.0, 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	
	# アニメーション完了後に削除
	tween.chain().tween_callback(queue_free)
