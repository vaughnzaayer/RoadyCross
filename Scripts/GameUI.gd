extends Control

@onready var gameplayInfo = $MarginContainer/GameplayInfo
@onready var scoreDisplay = $MarginContainer/GameplayInfo/ScoreDisplay
@onready var timeDisplay = $MarginContainer/GameplayInfo/TimeDisplay
@onready var carSelect = $MarginContainer/CarSelection
@onready var selectSedan = $MarginContainer/CarSelection/SelectSedan
@onready var selectMotorcycle = $MarginContainer/CarSelection/SelectMotorcycle
@onready var selectTruck = $MarginContainer/CarSelection/SelectTruck

@onready var sedanCdBar = $MarginContainer/CarSelection/SedanCdBar
@onready var motorcycleCdBar = $MarginContainer/CarSelection/MotorcycleCdBar
@onready var truckCdBar = $MarginContainer/CarSelection/TruckCdBar

@onready var mainMenu = $MarginContainer/Title
@onready var endscreen = $MarginContainer/Endscreen

@onready var startButton = $MarginContainer/Title/VBoxContainer/StartButton
@onready var quitButton = $MarginContainer/Title/VBoxContainer/QuitButton
@onready var returnButton = $MarginContainer/Endscreen/VBoxContainer/ReturnButton

@onready var endscreenScore = $MarginContainer/Endscreen/VBoxContainer/VBoxContainer/Score
@onready var endscreenHSNotification = $MarginContainer/Endscreen/VBoxContainer/VBoxContainer/HighscoreText

@onready var titleHSText = $MarginContainer/Title/VBoxContainer/Highscore

# List is populated in _ready() func
@onready var spawnCarButtons = []

var state = states.IDLE
var prevState

enum states {
	IDLE,
	GAMEPLAY,
	ENDSCREEN
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for _each in get_node("SpawnButtons").get_children():
		spawnCarButtons.append(_each)
	
	startButton.pressed.connect(Callable(self, "StartPressed"))
	quitButton.pressed.connect(Callable(self, "QuitPressed"))
	returnButton.pressed.connect(Callable(self, "ReturnPressed"))
	
	selectSedan.pressed.connect(Callable(self, "SedanSelected"))
	selectMotorcycle.pressed.connect(Callable(self, "MotorcycleSelected"))
	selectTruck.pressed.connect(Callable(self, "TruckSelected"))

	sedanCdBar.max_value = GameManager.sedanCdTime
	motorcycleCdBar.max_value = GameManager.motorcycleCdTime
	truckCdBar.max_value = GameManager.truckCdTime

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match state:
		states.IDLE:
			pass
		states.GAMEPLAY:
			scoreDisplay.text = "Score: " + str(GameManager.score)
			timeDisplay.text = CalculateTime()
	
	sedanCdBar.value = GameManager.sedanCdTime - GameManager.sedanCooldownTimer.time_left
	motorcycleCdBar.value = GameManager.motorcycleCdTime - GameManager.motorcycleCooldownTimer.time_left
	truckCdBar.value = GameManager.truckCdTime - GameManager.truckCooldownTimer.time_left
	
func ChangeState(newState):
	prevState = state
	state = newState
	
	EnterState(state)
	
func EnterState(newState):
	match newState:
		states.IDLE:
			IdleMode()
		states.GAMEPLAY:
			GameplayMode()
		states.ENDSCREEN:
			EndscreenMode()

func IdleMode():
	mainMenu.visible = true
	gameplayInfo.visible = false
	endscreen.visible = false
	carSelect.visible = false
	
	startButton.disabled = false
	quitButton.disabled = false
	returnButton.disabled = true
	selectSedan.disabled = true 
	selectMotorcycle.disabled = true
	selectTruck.disabled = true
	
	for _each in spawnCarButtons:
		_each.disabled = true
		_each.visible = false
	
	titleHSText.text = "Highscore: " + str(SaveData.highscore)

func GameplayMode():
	mainMenu.visible = false
	gameplayInfo.visible = true
	endscreen.visible = false
	carSelect.visible = true
	
	startButton.disabled = true
	quitButton.disabled = true
	returnButton.disabled = true
	selectSedan.disabled = false 
	selectMotorcycle.disabled = false
	selectTruck.disabled = false
	
	for _each in spawnCarButtons:
		_each.disabled = false
		_each.visible = true

func EndscreenMode():
	mainMenu.visible = false
	gameplayInfo.visible = false
	endscreen.visible = true
	carSelect.visible = false
	
	startButton.disabled = true
	quitButton.disabled = true
	returnButton.disabled = false
	selectSedan.disabled = true 
	selectMotorcycle.disabled = true
	selectTruck.disabled = true
	
	for _each in spawnCarButtons:
		_each.disabled = true
		_each.visible = false
	
	if GameManager.score > SaveData.highscore:
		endscreenHSNotification.visible = true
		GameManager.UpdateHS()
	else:
		endscreenHSNotification.visible = false
		
	endscreenScore.text = "Score: " + str(GameManager.score)
	
func CalculateTime():
	var rawTime = GameManager.gameTimer.get_time_left()
	
	var minutes = floori(rawTime / 60)
	var seconds = floori(rawTime - (minutes * 60))
	
	if seconds >= 10:
		return str(minutes) + ":" + str(seconds)
	else:
		return str(minutes) + ":0" + str(seconds)

func StartPressed():
	GameManager.ChangeState(GameManager.states.ACTIVE)
	
func QuitPressed():
	get_tree().quit()
	
func ReturnPressed():
	GameManager.ChangeState(GameManager.states.IDLE)
	
func SedanSelected():
	GameManager.currentCar = GameManager.carSelection.SEDAN
	print('Selected Sedan')
	
func MotorcycleSelected():
	GameManager.currentCar = GameManager.carSelection.MOTORCYCLE
	print('Selected Motorcycle')
	
func TruckSelected():
	GameManager.currentCar = GameManager.carSelection.TRUCK
	print('Selected Truck')
	

