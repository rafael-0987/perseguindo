extends CharacterBody2D

#---fique avontade para estudar, utilizar e ate mesmo melhorar =)---

@onready var nav: NavigationRegion2D = $"../NavigationRegion2D"
@onready var nav_agent: NavigationAgent2D = $Sprite2D/NavigationAgent2D

#---alvo, isso e oque o nosso "perseguidor" tem que seguir---
@export var target: CharacterBody2D


func _physics_process(_delta: float) -> void:
	#---printando---
	#print(NavigationServer2D.agent_get_map(nav_agent).is_valid())
	
	#---verificanco se a sincronização do nav_agent foi criada---
	if !NavigationServer2D.agent_get_map(nav_agent).is_valid():
		return
	
	#---a direção aonde o OBJ tem que ir---
	var direction = Vector3()
	
	#---atualizando a posição do "target_position", com a posição da variavel target---
	nav_agent.target_position = target.global_position
	
	#---fala que a direção vai ser o proximo caminho diminuindo a sua propria posição---
	direction = nav_agent.get_next_path_position() - global_position
	#---normalizando os vetores---
	direction = direction.normalized()
	
	#---apricando os valores ao velocity---
	velocity = velocity.lerp(direction * 250, 1.5 )
	#---fazendo ele mover e colidir---
	move_and_slide()
