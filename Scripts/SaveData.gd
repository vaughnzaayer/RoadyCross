extends Node

var highscore = 0
const FILEPATH = "user://savedata.bruh"

func Save():
	var file = FileAccess.open(FILEPATH, FileAccess.WRITE)
	file.store_32(highscore)
	file.close()
	
func Load():
	if FileAccess.file_exists(FILEPATH):
		var file = FileAccess.open(FILEPATH, FileAccess.READ)
		highscore = file.get_32()
		file.close()
	else:
		print("errrr this file doesn't exist :nerd:")
	
func Delete():
	highscore = 0
	Save()
