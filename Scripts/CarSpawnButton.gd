extends Node

@onready var sedan = preload("res://Scenes/Cars/Sedan.tscn")
@onready var motorcycle = preload("res://Scenes/Cars/Motorcycle.tscn")
@onready var truck = preload("res://Scenes/Cars/Truck.tscn")

@onready var spawnPos = get_node("Marker2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var c
	match GameManager.currentCar:
		GameManager.carSelection.SEDAN:
			c = sedan.instantiate()
		GameManager.carSelection.MOTORCYCLE:
			c = motorcycle.instantiate()
		GameManager.carSelection.TRUCK:
			c = truck.instantiate()
	c.global_position.y += 30
	add_child(c)
