extends Camera2D

var players

# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_tree().get_nodes_in_group("chasers") \
		+ get_tree().get_nodes_in_group("targets")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate bbox center
	var min_x = 1e9
	var min_y = 1e9
	var max_x = -1e9
	var max_y = -1e9
	
	for player in players:
		min_x = min(min_x, player.position.x)
		min_y = min(min_y, player.position.y)
		max_x = max(max_x, player.position.x)
		max_y = max(max_y, player.position.y)
	
	self.offset = Vector2((min_x + max_x) / 2.0, (min_y + max_y) / 2.0)
