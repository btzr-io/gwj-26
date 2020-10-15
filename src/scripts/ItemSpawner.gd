extends Node2D

var worldItems = []

var rows = 5
var columns = 3

#space between each item
var offset = 325

#with these starting values, it fills the screen
#var x_start = 290
#var y_start = 144

#keep x the same but multiple 144 by any factor to move the items up and make the y negative
var x_start = 290
var y_start = -1152

const JAM = preload("res://scenes/Items/Jam.tscn")
const BUTTER = preload("res://scenes/Items/Butter.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	worldItems = createArray(columns, rows)
	#printArray()
	spawnItems(worldItems, columns, rows)

func createArray(columns, rows):
	#Symbols for obstacles - Knife, Butter, Jam, Blank
	var itemOptions = ["K", "B", "J", " "]
	for x in range(columns):
		worldItems.append([])
		worldItems[x].resize(rows)
		
		#randomly assigns a symbol to the world grid
		for y in range(rows):
			randomize()
			worldItems[x][y] = itemOptions[randi() % itemOptions.size()]
			print("[%s]" % worldItems[x][y])
			
	return worldItems

func spawnItems(worldItems, columns, rows):
	for x in range(columns):
		for y in range(rows):
			var item
			print("Item Symbol: %s" % worldItems[x][y])
			print("X is: [%s]" % x)
			print("Y is: [%s]" % y)
			if worldItems[x][y] == "B":
				item = BUTTER.instance()
				#print("Item is butter")
			if worldItems[x][y] == "J":
				item = JAM.instance()
				#print("Item is jam")
			#If it's the first item to spawn
			if item:
				if x == 0 && y == 0:
					item.position.x = x_start
					item.position.y = y_start
				elif x == 0 && y != 0:
					#print("First item")
					item.position.x = x_start
					item.position.y = (offset * y) + y_start
					#print("Item position is: %s" % item.position)
				elif y == 0 && y != 0:
					item.position.x = (offset * x) + x_start
					item.position.y = y_start
				else:
					#print("Not first item")
					item.position.x = (offset * x) + x_start
					item.position.y = (offset * y) + y_start
				print("Item position is: %s" % item.position)
				add_child(item)

#For debugging					
func printArray():
	for x in range(columns):
		for y in range(rows):
			print("[%s]" % worldItems[x][y])
