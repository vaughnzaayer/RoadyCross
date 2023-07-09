class_name Car extends Node2D

var speed = 100
var damage = 1
var direction = Vector2.RIGHT
var cooldown = 3.0

@export var end_zone = 1100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.x >= end_zone:
		#print("target reached")
		queue_free()
	else:
		global_position.x = lerp(global_position.x, global_position.x + speed, 0.14)
