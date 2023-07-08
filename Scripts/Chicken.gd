extends Animal

# Called when the node enters the scene tree for the first time.
func _ready():
	# test code REMEMBER TO COMMENT THIS OUT
	super()
	Spawn(50, 2, 1, 1, 100, Vector2(500, 500))
