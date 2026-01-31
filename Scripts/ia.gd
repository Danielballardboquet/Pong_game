extends CharacterBody2D

@export var speed:float = 300
var x:float = 0
var y:float = 0
var pos_x
var space:bool = false

func _ready() -> void:
	pos_x = position.x
	
func _physics_process(delta: float) -> void:
	if get_node("/root/Game/Ball") != null:
		y = get_node("/root/Game/Ball").position.y - position.y
	
	if y > 1:
		y = 1
	if y < -1:
		y = -1
	
	velocity = Vector2(0,y) * speed
	
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		
	if position.x != pos_x:
		position.x = pos_x
		
	move_and_slide()
