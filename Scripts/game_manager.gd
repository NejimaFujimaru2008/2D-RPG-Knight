extends Node

signal score_changed(new_score)
signal level_unlocked(level)

var score = 0
var unlocked_levels = [1]   # Level 1 is always unlocked

func add_point():
	score += 1
	print(score)
	score_changed.emit(score)

func reset_score():
	score = 0
	score_changed.emit(score)

func is_level_unlocked(level: int) -> bool:
	return level in unlocked_levels

func unlock_level(level: int):
	if level not in unlocked_levels:
		unlocked_levels.append(level)
		level_unlocked.emit(level)
		print("Unlocked level: ", level)   # for debugging

func complete_level(level: int):
	var next_level = level + 1
	if next_level <= 10:   # assuming 10 levels total
		unlock_level(next_level)
