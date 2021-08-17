extends Node2D

export var websocket_url = "ws://10.42.0.1:1338"

const Chaser = preload("res://chaser.tscn")

var _client = WebSocketClient.new()
var data = {}

func _ready():
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")
	set_process(true)
	
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)

func _connected(_proto = ""):
	print("Connected!")
	_client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	_client.get_peer(1).put_packet("get".to_utf8())

func _on_data():
	data = JSON.parse(_client.get_peer(1).get_packet().get_string_from_utf8()).get_result()
	
	while get_tree().get_nodes_in_group("chasers").size() < data.keys().size():
		var new_chaser = Chaser.instance();
		new_chaser.index = get_tree().get_nodes_in_group("chasers").size() + 1
		new_chaser.set_sprite(new_chaser.index)
		# TODO: it would probably be good to have specific spawning points later
		new_chaser.position = Vector2(600,120)
		
		self.add_child(new_chaser, true)
	_client.get_peer(1).put_packet("get".to_utf8())

func _process(_delta):
	_client.poll()

func get_data(index):
	if data.keys().size() > index:
		return data[data.keys()[index]]
	else:
		return [0,0]
