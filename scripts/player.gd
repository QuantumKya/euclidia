extends CharacterBody2D
class_name Player;

@onready var ray_scn = preload("res://parts_scn/ray.tscn");

@onready var eyesUp = preload("res://sprite/character/character_eyes_up.png");
@onready var eyesOn = preload("res://sprite/character/character_eyes_on.png");
@onready var eyesDn = preload("res://sprite/character/character_eyes_down.png");

@onready var head = $Head;
@onready var body = $Body;
@onready var arms = $Arms;
@onready var eyes = $Eyes;

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var rayLimit = 0;
var activeRays: Array = [];


func _ready() -> void:
	emit_ray_update();
	EventManager.ray_upgraded.connect(_on_ray_upgraded);

func _on_ray_upgraded() -> void:
	rayLimit += 1;
	emit_ray_update();

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") && activeRays.size() < rayLimit:
		shoot_ray();
	
	if Input.is_action_just_pressed("unshoot") && activeRays.size() > 0:
		activeRays.pop_at(0).queue_free();
		
		emit_ray_update();

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if not is_on_floor():
		if velocity.y < 0:
			eyes.texture = eyesUp;
		elif abs(velocity.y) < 256:
			eyes.texture = eyesOn;
		else:
			eyes.texture = eyesDn;
	else:
		eyes.texture = eyesOn;
	
	if velocity.x < 0:
		head.flip_h = true;
		eyes.flip_h = true;
		arms.flip_h = true;
		body.flip_h = true;
	elif velocity.x == 0:
		pass;
	else:
		head.flip_h = false;
		eyes.flip_h = false;
		arms.flip_h = false;
		body.flip_h = false;

	move_and_slide()


func shoot_ray() -> void:
	var ray = ray_scn.instantiate();
	var diff = get_global_mouse_position() - position;
	var angle = atan2(diff.y, diff.x);
	ray.position = position + (Vector2(-32, 0) if (body.flip_h) else Vector2(32, 0));
	ray.points.fill(Vector2.ZERO);
	ray.angle = angle;
	activeRays.append(ray);
	add_sibling(ray);
	
	emit_ray_update();

func emit_ray_update() -> void:
	EventManager.emit_signal("ray_update", activeRays.size(), rayLimit);
