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
		$AnimatedSprite2D.rotation = deg_to_rad(90)
		$Bullets_eating_area.rotation = deg_to_rad(90*lastdiry)
		if diry<0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		match lastdirx:
			-1:
				$AnimatedSprite2D.flip_v = false
			1:
				$AnimatedSprite2D.flip_v = true
	if dirx:
		velocity.x = speed*dirx
		velocity.y = 0
		lastdirx = dirx
		lastdiry = 0
		$AnimatedSprite2D.rotation = deg_to_rad(0)
		$Bullets_eating_area.rotation = deg_to_rad(90-90*lastdirx)
		if dirx<0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	if Input.is_action_just_pressed("Space"):
		shield()
	if Input.is_action_just_pressed("Esc"):
		$AnimatedSprite2D.stop()
		state = 2
	move_and_slide()

func pause() -> void:
	if Input.is_action_just_pressed("Esc"):
		velocity.x = speed*lastdirx
		velocity.y = speed*lastdiry
		move_and_slide()
		$AnimatedSprite2D.play("Eating")
		state = 1

func cutscene() -> void:
	pass

func shield() -> void:
	$Shield.modulate = Color(0.0, 0.0, 0.0, 1.0)
	var untwin : Tween = get_tree().create_tween()
	untwin.tween_property($Shield, 'modulate:a', 0, 0.3)
	$ProgressBar.value = 100
	$ProgressBar.visible = true
	


func _on_bullets_eating_area_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
