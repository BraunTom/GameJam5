extends KinematicBody2D

# class member variables go here, for example:
var velocity = Vector2(0, 0);
var speed = 300;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func process_input(delta):
	var direction = Vector2(0,0)
	
	if Input.is_action_pressed('move_down'):
		direction.y += 1
	if Input.is_action_pressed('move_up'):
		direction.y -= 1
	
	if Input.is_action_pressed('move_right'):
		direction.x += 1
	if Input.is_action_pressed('move_left'):
		direction.x -= 1
	
	velocity = direction.normalized() * speed
	
func rotate_toward_mouse():
	var mousePos = self.get_global_mouse_position()
	var transform = self.get_transform()
	self.look_at(mousePos)
	


func _physics_process(delta):
	process_input(delta)
	rotate_toward_mouse()
	velocity = self.move_and_slide(velocity)
	
func clear_pickup():
	for child in $GrabbingHand.get_children():
		child.queue_free()

func pick_up(pickup):
	self.clear_pickup()
	pickup.picked_up_by(self)
	$GrabbingHand.add_child(pickup)
	print($GrabbingHand.get_children())