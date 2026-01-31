extends CharacterBody2D

var ini_pos

var left:int = 0
var right:int = 0
var counter:int = 0


func _ready() -> void:
	velocity = Vector2(1,0.5)*200
	ini_pos = position

func _physics_process(delta: float) -> void:
	var col = move_and_collide(velocity*delta)
	if col == null:
		counter = 0
	if col != null:
		counter += 1
		
		if col.get_collider().is_in_group("Paddle"):
			velocity = velocity.bounce(col.get_normal())
			velocity += col.get_collider().velocity*0.04+Vector2(10,0)
			if abs(col.get_normal().x) < 0.05:
				velocity.x = -1.5*velocity.x
				 
			if col.get_collider().space:
				velocity *= 1.5
		
		if col.get_collider().is_in_group("Wall"):
			velocity = velocity.bounce(col.get_normal())
			
		
		if col.get_collider().is_in_group("LeftWall"):
			position = ini_pos
			velocity  = Vector2(1,0.5)*200
			right += 1
			get_node("/root/Game/Control/RightLabel").text = str(right)
			if right >= 20:
				get_tree().quit()
				
		if col.get_collider().is_in_group("RightWall"):
			position = ini_pos
			velocity  = Vector2(-1,0.5)*200
			left += 1
			get_node("/root/Game/Control/LeftLabel").text = str(left)
			if left >= 20:
				get_tree().quit()
		
		if counter > 3:
			velocity = Vector2((ini_pos.x-position.x)/100,randf()*20-10)*100
		
		if counter > 10:
			position = ini_pos
