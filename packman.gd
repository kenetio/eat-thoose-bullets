extends CharacterBody2D

var state : int = 1
var speed = 500.0

var lastdirx : int = 0
var lastdiry : int = 0


func _physics_process(_delta: float) -> void:
	match state:
		1:
			move()
		2:
			pause()
		3:
			cutscene()

func move() -> void:
	var dirx : int = Input.get_axis("A", "D")
	var diry : int = Input.get_axis("W", "S")
	$AnimatedSprite2D.play("Eating")
	if diry:
		velocity.y = speed*diry
		velocity.x = 0
		lastdiry = diry
		lastdirx = 0
		$AnimatedSprite2D.rotation = deg_to_rad(90*lastdirx)
		if diry<0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	if dirx:
		velocity.x = speed*dirx
		velocity.y = 0
		lastdirx = dirx
		lastdiry = 0
		$AnimatedSprite2D.rotation = deg_to_rad(0)
		if dirx<0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	if Input.is_action_just_pressed("Space"):
		shield()
	if Input.is_action_just_pressed("Esc"):
		state = 2
	move_and_slide()

func pause() -> void:
	if Input.is_action_just_pressed("Esc"):
		velocity.x = speed*lastdirx
		velocity.y = speed*lastdiry
		move_and_slide()
		state = 1

func cutscene() -> void:
	pass

func shield() -> void:
	$Shield.modulate = Color(0.0, 0.0, 0.0, 1.0)
	var untwin : Tween = get_tree().create_tween()
	untwin.tween_property($Shield, 'modulate:a', 0, 0.3)
	$ProgressBar.value = 100
	$ProgressBar.visible = true
	
