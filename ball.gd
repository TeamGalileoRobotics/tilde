extends RigidBody2D

export var speed = 10
export var index = 1

func _ready():
	set_process(true)

func _physics_process(_delta):
	var data = get_parent().get_data(index)
	var impulse = Vector2(data[0], -data[1])
	set_applied_force(impulse*speed)

func set_sprite(index):
	$sprite.texture = load("res://chaser_%s.png" % index)
