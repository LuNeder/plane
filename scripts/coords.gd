extends RichTextLabel

@onready var player = $/root/Node3D/Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "x" + str(player.position.x)
