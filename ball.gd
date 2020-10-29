extends RigidBody2D

const SPEED = 10
var impulse = Vector2(0.3,0.3)
export var index = 1

func _ready():
	set_process(true)

func _physics_process(_delta):
	var playerdata = get_parent().get_data(index)
	impulse = Vector2(playerdata[0], -playerdata[1])
	set_applied_force(impulse*SPEED)	
