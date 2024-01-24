extends Node

var underwater = true
var water_override = false
var air_override = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	water_override = false
	air_override = false
