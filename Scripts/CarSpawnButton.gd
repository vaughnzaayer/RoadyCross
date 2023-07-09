extends Node

@onready var sedan = preload("res://Scenes/Cars/Sedan.tscn")
@onready var motorcycle = preload("res://Scenes/Cars/Motorcycle.tscn")
@onready var truck = preload("res://Scenes/Cars/Truck.tscn")

@onready var spawnPos = get_node("Marker2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_pressed():
	var c = null
	match GameManager.currentCar:
		GameManager.carSelection.SEDAN:
			if GameManager.sedanAvailable:
				c = sedan.instantiate()
				GameManager.SedanCooldown()
		GameManager.carSelection.MOTORCYCLE:
			if GameManager.motorcycleAvailable:
				c = motorcycle.instantiate()
				GameManager.MotorcycleCooldown()
		GameManager.carSelection.TRUCK:
			if GameManager.truckAvailable:
				c = truck.instantiate()
				GameManager.TruckCooldown()
	if c == null: return
	c.global_position.y += 30
	add_child(c)
