extends Label


func _ready() -> void:
	update_score_text()

func _process(_delta: float) -> void:
	# 💡 每一帧同步最新的全局分数
	update_score_text()

func update_score_text() -> void:
	# 假设 Label 的显示效果是 "0" 或 "Score: 0"
	text = str(Global.score)
