extends Area2D

const FLOATING_SCORE_SCENE := preload("res://Scenes/VFX/floating_score.tscn")

# 当Player碰到金币时触发
func _on_body_entered(body):
	# 只对Player生效
	if body.name == "Player":
		_spawn_floating_score()
		# 找到场景里的分数标签
		var score_label = get_parent().get_node("ScoreLabel")
		# 读取当前分数，加1
		var current_score = int(score_label.text.split("：")[1])
		current_score += 1
		# 更新分数显示
		score_label.text = "分数：" + str(current_score)
		# 删除金币
		queue_free()


func _spawn_floating_score() -> void:
	var fx = FLOATING_SCORE_SCENE.instantiate()
	fx.global_position = global_position + Vector2(0, -24)
	get_parent().add_child(fx)

func _ready():
	# 绑定碰撞信号
	body_entered.connect(_on_body_entered)
