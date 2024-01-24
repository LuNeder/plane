extends Area3D
signal aair

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	PlayerVariables.air_override += 1
	if "Player" not in str(get_overlapping_bodies()):
		PlayerVariables.air_override -= 1
	else:
		PlayerVariables.underwater = false
#		PlayerVariables.air_override = false

