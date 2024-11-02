extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D;

@export var speed: float = 185;

var direction: Vector2 = Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("idle");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	flip_sprite();

func _physics_process(delta: float) -> void:
	move_player();
	debug_collisions();

func flip_sprite() -> void:
	if(Input.is_action_just_pressed("ui_left")):
		animated_sprite.flip_h = true;

	if(Input.is_action_just_pressed("ui_right")):
		animated_sprite.flip_h = false;
	
func move_player() -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if(direction == Vector2.ZERO):
		velocity = Vector2.ZERO;
	else: 
		velocity = direction * speed;
	
	move_and_slide();

func debug_collisions() -> void:
	var collisions_count = get_slide_collision_count();
	if(collisions_count == 0):
		return;

	for collision_index in range(collisions_count):
		var collision: KinematicCollision2D = get_slide_collision(collision_index);
		print_debug(collision.get_collider());