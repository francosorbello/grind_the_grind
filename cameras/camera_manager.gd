extends Node


@export var decay := 0.8 #How quickly shaking will stop [0,1].
@export var max_offset := Vector2(100,75) #Maximum displacement in pixels.
@export var max_roll := 0.1 #Maximum rotation in radians (use sparingly).
@export var noise : FastNoiseLite #The source of random values.

var noise_y = 0 #Value used to move through the noise

var trauma := 0.0 #Current shake strength
var trauma_pwr := 3 #Trauma exponent. Use [2,3]
var camera : Camera3D #The camera to shake

func _ready():
	camera = get_viewport().get_camera_3d()
	randomize()
	noise.seed = randi()

func add_trauma(amount : float):
	trauma = min(trauma + amount, 1.0)

func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
#   #optional
# 	elif camera.offset.x != 0 or camera.offset.y != 0 or camera.rotation != Vector3.ZERO:
# 		lerp(camera.offset.x,0.0,1)
# 		lerp(camera.offset.y,0.0,1)
# 		lerp(camera.rotation,0.0,1)

func shake(): 
	var amt = pow(trauma, trauma_pwr)
	noise_y += 1
	camera.rotation = max_roll * amt * noise.get_noise_2d(noise.seed,noise_y)
	camera.offset.x = max_offset.x * amt * noise.get_noise_2d(noise.seed*2,noise_y)
	camera.offset.y = max_offset.y * amt * noise.get_noise_2d(noise.seed*3,noise_y)
