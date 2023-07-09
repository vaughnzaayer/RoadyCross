extends Node2D

# spawn timer, spawn points, and animal holder node
@onready var spawnTimer = $Timer
@onready var spawnPoints = $SpawnPolnts
@onready var animals = $Animals

# time between animal spawns
var spawnTime = 3

# animal packed scenes
@onready var chicken = preload("res://Scenes/Animals/Chicken.tscn")
@onready var squirrel = preload("res://Scenes/Animals/Squirrel.tscn")
@onready var frog = preload("res://Scenes/Animals/Frog.tscn")
@onready var bear = preload("res://Scenes/Animals/Bear.tscn")

# arrays of spawnpoints and animals that will be filled later
var points = []
var animalList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# fill arrays of spawn points and possible animals to spawn
	points = spawnPoints.get_children()
	animalList = [chicken, squirrel, frog, bear]
	
	# set up timer
	spawnTimer.timeout.connect(Callable(self, "SpawnTimeout"))
	spawnTimer.one_shot = true
	spawnTimer.wait_time = spawnTime

# starts the spawner
func Activate():
	spawnTimer.start()

# stops the spawner
func Deactivate():
	spawnTimer.stop()
	
# deletes all currently active animals
func ClearAnimals():
	for i in animals.get_children():
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# spawns a random animal at a random spawn location
func SpawnAnimal():
	# get random spawn position and animal
	var spawnPos = points[randi() % points.size()].global_position
	var animal = animalList[randi() % animalList.size()]
	
	# instantiate animal at position
	var sp = animal.instantiate()
	animals.add_child(sp)
	sp.Spawn(spawnPos)

# called when spawn timer runs down
func SpawnTimeout():
	SpawnAnimal()
	spawnTimer.start()
