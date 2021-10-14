extends RigidBody2D

export var speed = 10

var index = 1

func _ready():
	set_process(true)

func _physics_process(_delta):
	var data = get_parent().get_data(index)
	var impulse = Vector2(data[0], -data[1])
	set_applied_force(impulse * speed)

func set_index(index):
	self.index = index
	if self.index == 0:
		# This is the target
		self.add_to_group("targets")
		$sprite.texture = load("res://target.png")
	else:
		# This is a chaser
		self.add_to_group("chasers")
		$sprite.texture = load("res://chaser_%s.png" % self.index)

func _on_player_body_entered(body):
	if self.is_in_group("targets") and body.is_in_group("chasers"):
		print("Collision!")
		get_tree().reload_current_scene()
