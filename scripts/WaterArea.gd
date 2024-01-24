extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	PlayerVariables.water_override += 1
	if "Player" not in str(get_overlapping_bodies()):
		PlayerVariables.water_override -= 2
	else:
		PlayerVariables.underwater = true
#		PlayerVariables.water_override = false # Cant set the override to false in here bc otherwise they'll fight and might be false when it should be true
