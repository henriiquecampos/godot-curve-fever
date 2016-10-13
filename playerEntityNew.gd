extends Node

onready var head = get_node("head")
onready var tail = get_node("tail")

export var threshold = 0
export (String) var left
export (String) var right
export (Color) var color
var coll = preload("res://coll.tscn")
var points = []

func _ready():
	set_fixed_process(true)
	points.append(tail.get_pos())
	points.append(head.get_pos())

func _fixed_process(delta):
	if Input.is_action_pressed("ui_accept"):
		get_tree().set_pause(true)
	head.translate(Vector2(0,-threshold * delta).rotated(head.get_rot()))
	if Input.is_action_pressed(right):
		head.rotate(-3 * delta)
	elif Input.is_action_pressed(left):
		head.rotate(3 * delta)
	if head.get_pos().distance_to(points[points.size() -1]) > 10:
		update()
func _draw():
	var last
	var current

	for i in range(0,points.size() -1):
		last = points[i]
		current = points[i + 1]
		draw_line(points[i], points[i + 1], color, 10)
	var c = coll.instance()
	var line = SegmentShape2D.new()
	line.set_a(last)
	line.set_b(current)
	self.add_child(c)
	c.set_shape(line)
	points.append(head.get_pos())