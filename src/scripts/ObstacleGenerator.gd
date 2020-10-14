extends Node2D

var obstacles = {}

var columns = 3
var rows = 10

var worldItems = []

func _ready():
	createArray(columns, rows)
	printArray()

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

#For debugging					
func printArray():
	for x in range(columns):
		for y in range(rows):
			print("[%s]" % worldItems[x][y])
