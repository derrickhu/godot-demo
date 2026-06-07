extends Area2D

# 当物体进入金币的碰撞范围时触发
func _on_body_entered(body):
	# 判断进入的物体是不是Player
	if body.name == "Player":
		# 金币被拾取，直接从场景中删除
		queue_free()

func _ready():
	# 绑定碰撞信号：物体进入时调用_on_body_entered函数
	body_entered.connect(_on_body_entered)
