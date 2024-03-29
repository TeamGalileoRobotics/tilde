extends Camera2D

export var min_zoom = 0.1
export var max_zoom = 1
export var margin = 150
export var zoom_smoothness = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var players = get_tree().get_nodes_in_group("chasers") \
		+ get_tree().get_nodes_in_group("targets")
	
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
	
	self.position = Vector2((min_x + max_x) / 2.0, (min_y + max_y) / 2.0)
	
	# Calculate zoom level
	var screen_size = self.get_viewport_rect().size
	var x_fac = (max_x - min_x + margin) / screen_size.x
	var y_fac = (max_y - min_y + margin) / screen_size.y
	var val = max(min(max(x_fac, y_fac), max_zoom), min_zoom)
	self.zoom = self.zoom.linear_interpolate(Vector2(1, 1) * val, zoom_smoothness * delta)
