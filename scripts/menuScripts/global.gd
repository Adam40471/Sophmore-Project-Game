extends Node

#The currently active scene
var currentScene = null

func _ready():
   #On load set the current scene to the last scene available
   currentScene = get_node("res://scenes/menuScenes/MainMenu.tscn")
   #Demonstrate setting a global variable.
   print("HI")
   
# create a function to switch between scenes 
func setScene(scene):
   #clean up the current scene
   currentScene.queue_free()
   #load the file passed in as the param "scene"
   var s = ResourceLoader.load(scene)
   #create an instance of our scene
   currentScene = s.instance()
   # add scene to root
   get_tree().get_root().add_child(currentScene)
