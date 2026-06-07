extends Node2D

## 拾取反馈：向上飘并淡出（用 _draw 画字，不依赖 Label2D）

@export var display_text: String = "+1"
@export var float_distance: float = 56.0
@export var duration: float = 0.75
@export var font_size: int = 36

var _alpha: float = 1.0


func _ready() -> void:
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position:y", position.y - float_distance, duration)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_method(_set_alpha, 1.0, 0.0, duration)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.chain().tween_callback(queue_free)
	queue_redraw()


func _set_alpha(value: float) -> void:
	_alpha = value
	queue_redraw()


func _draw() -> void:
	var font := ThemeDB.fallback_font
	var text_size := font.get_string_size(display_text, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size)
	var pos := Vector2(-text_size.x * 0.5, text_size.y * 0.3)
	var color := Color(1.0, 0.92, 0.25, _alpha)
	var outline := Color(0.1, 0.08, 0.0, _alpha * 0.85)
	# 简单描边：四个方向各画一次
	for offset in [Vector2(-2, 0), Vector2(2, 0), Vector2(0, -2), Vector2(0, 2)]:
		font.draw_string(get_canvas_item(), pos + offset, display_text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, outline)
	font.draw_string(get_canvas_item(), pos, display_text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, color)
