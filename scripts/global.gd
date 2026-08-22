extends Node

# 💡 全局变量：存储玩家当前的剩余生命值（默认 3 条命）
var current_health: int = 3
var max_health: int = 3

# 重置血量（方便回到主菜单或重新开始游戏时调用）
func reset_health() -> void:
	current_health = max_health

# 🪙 添加全局分数变量
var score: int = 0

func reset_game() -> void:
	current_health = max_health
	score = 0 
