extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
@export var jump_impulse = 20

var target_velocity = Vector3.ZERO
var underwater = true

@onready var water_area = $/root/Node3D/WaterArea
@onready var air_area = $/root/Node3D/AirArea

func _ready():
	WaterSignal.water_signal.connect(_water_signal)

func _physics_process(delta):
	#Movement
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO
	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	# Jump
	if is_on_floor() and Input.is_action_just_pressed("move_up"):
		target_velocity.y = jump_impulse
	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	
#	# Iterate through all collisions that occurred this frame
#	for index in range(get_slide_collision_count()):
#		# We get one of the collisions with the player
#		var collision = get_slide_collision(index)
#		# If the collision is with ground
#		if collision.get_collider() == null:
#			continue
#		if collision.get_collider().is_in_group("water"):
#			underwater = true
#		if collision.get_collider().is_in_group("air"):
#			underwater = false
#			# Prevent further duplicate calls.
#			break
	

	
	for index in range(get_slide_collision_count()):
		# We get one of the collisions with the player
		var collision = get_slide_collision(index)
		# If the collision is with ground
		if collision.get_collider() == null:
			continue
		if position.y <= 0:
			underwater = not collision.get_collider().is_in_group("air")
		else:
			underwater = collision.get_collider().is_in_group("water")
		

	# testing
	print('underwater ' + str(underwater))
	print(str(water_area.get_overlapping_bodies())) # This detects the player!!

func _water_signal():
	print("water-sig")
