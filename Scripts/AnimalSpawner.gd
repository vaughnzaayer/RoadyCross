extends Node2D

@onready var spawnTimer = $Timer
@onready var spawnPoints = $SpawnPolnts
@onready var animals = $Animals

var spawnTime = 3

@onready var chicken = preload("res://Scenes/Animals/Chicken.tscn")
@onready var squirrel = preload("res://Scenes/Animals/Squirrel.tscn")
@onready var frog = preload("res://Scenes/Animals/Frog.tscn")
@onready var bear = preload("res://Scenes/Animals/Bear.tscn")

var points = []
var animalList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	points = spawnPoints.get_children()
	animalList = [chicken, squirrel, frog, bear]
	
	spawnTimer.timeout.connect(Callable(self, "spawnTimeout"))
	spawnTimer.one_shot = true
	spawnTimer.wait_time = spawnTime
	
	Activate()
	
func Activate():
	spawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func SpawnAnimal():
	var spawnPos = points[randi() % points.size()].global_position
	
	var animal = animalList[randi() % animals.size()]
	
	var sp = animal.instance()
	animals.add_child(sp)
	sp.Spawn(spawnPos)
	
func SpawnTimeout():
	SpawnAnimal()
	spawnTimer.start()
