extends Node2D

var worldItems = []

var columns = 3
var rows = 10

var y_offset = 350
var x_offset = 270

var butter = load("res://scenes/Items/Butter.tscn")
var jam = load("res://scenes/Items/Jam.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	worldItems = createArray(columns, rows)
	printArray()
	spawnItems(worldItems, columns, rows)

func createArray(columns, rows):
	#Symbols for obstacles - Knife, Butter, Jam, Blank
	var itemOptions = ["K", "B", "J", " "]
	for x in range(columns):
		worldItems.append([])
		worldItems[x].resize(rows)
		
		#randomly assigns a symbol to the world grid
		for y in range(rows):
			worldItems[x][y] = itemOptions[randi() % itemOptions.size()]
			#print("[%s]" % worldItems[x][y])
			
	return worldItems

func spawnItems(worldItems, columns, rows):
	for x in range(columns):
		for y in range(rows):
			if worldItems[x][y] == "B":
				var butterItem = butter.instance()
				butterItem.position.x = x_offset
				butterItem.position.y = y_offset
				add_child(butterItem)
			if worldItems[x][y] == "J":
				var jamItem = jam.instance()
				jamItem.position.x = randi() % y_offset
				jamItem.position.y = randi() % x_offset
				add_child(jamItem)

#For debugging					
func printArray():
	for x in range(columns):
		for y in range(rows):
			print("[%s]" % worldItems[x][y])
