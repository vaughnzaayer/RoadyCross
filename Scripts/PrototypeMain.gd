extends Node

# Gather list of spawn points for the animals & spawn timer
@onready var spawnPoints = [$SpawnPoint1, $SpawnPoint2, $SpawnPoint3, $SpawnPoint4]
@onready var spawnTimer = $SpawnTimer
# Preload chicken scene for instancing
@onready var chicken = preload("res://Scenes/TestAnimal.tscn")

# Spawn chicken every spawnInterval (3.0 = 3 seconds)
@export var spawnInterval = 3.0


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize spawn interval
	spawnTimer.set_wait_time(spawnInterval)
	spawnTimer.start()
	print('Game start!')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	print('Animal Spawned')
	# Instantiate chicken
	var ckn = chicken.instantiate()
	add_child(ckn)
	ckn.Spawn(64, 2, 1, 1, 100, spawnPoints[randi() % spawnPoints.size()].global_position)
	#ckn.global_position = spawnPoints[randi() % spawnPoints.size()].global_position
