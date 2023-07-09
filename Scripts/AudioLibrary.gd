class_name AudioLibrary extends Node2D

var sounds = []

func _ready():
	for i in get_children():
		if i is AudioStreamPlayer:
			sounds.append(i)
	
func Play(sound):
	for i in sounds:
		if i.name == sound:
			i.play()
			
func StopAll():
	for i in sounds:
		i.stop()
		
func PlayOnly(sound):
	StopAll()
	Play(sound)
