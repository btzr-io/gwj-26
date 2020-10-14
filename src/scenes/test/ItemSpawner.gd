extends Node2D

var worldItems = []

var columns = 3
var rows = 10

var y_offset = 800
var x_offset = 270
var currItemPos_X
var currItemPos_Y

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
	var item
	for x in range(columns):
		for y in range(rows):
			if worldItems[x][y] == "B":
				item = butter.instance()
			if worldItems[x][y] == "J":
				item = jam.instance()
			#If it's the first item to spawn
			if x == 0 && y == 0:
				print("First item")
				item.position.x = x_offset
				item.position.y = y_offset
				print(item.position)
			else:
				print("Not first item")
				item.position.x = x * x_offset
				item.position.y = y * y_offset
				print(item.position)
			add_child(item)

#For debugging					
func printArray():
	for x in range(columns):
		for y in range(rows):
			print("[%s]" % worldItems[x][y])
