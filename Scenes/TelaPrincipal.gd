# TelaPrincipal.gd
extends Control

# --- REFERÊNCIAS DOS BOTÕES ---
# (Botão de Garagem atualizado para TextureButton)
@onready var garagem_image_button: TextureButton = $GaragemImageButton 
@onready var configuracao_button: Button = $ConfiguracaoButton
@onready var loja_button: Button = $LojaButton
@onready var correr_image_button: TextureButton = $CorrerImageButton

<<<<<<< HEAD
# --- REFERÊNCIAS VISUAIS ---
# (Atualizado para TextureRect conforme seu feedback de erro)
@onready var personagem_sprite: TextureRect = $Personagem 

# --- VARIÁVEIS DE ANIMAÇÃO ---
var correr_button_pos_original: Vector2

# -------------------------------------------------------------------
# A Função _ready() COMEÇA AQUI
# -------------------------------------------------------------------
=======
@onready var container_car: Control = $ContainerCar 
@onready var container_character: Control = $ContainerCharacter

const PLAYER_VISUAL_CENA = preload("res://Objects/PlayerVisual.tscn") # Pré-carrega a cena
var player_visual_instance: Node2D = null

>>>>>>> be149d61e6375892048ca711c0d1dde457a49a9e
func _ready():
	# Conecta os botões do menu
	# (Conexão da Garagem atualizada)
	garagem_image_button.pressed.connect(func(): _ir_para("Garagem")) 
	
	configuracao_button.pressed.connect(func(): _ir_para("Configuracao"))
	loja_button.pressed.connect(func(): _ir_para("Loja"))
	correr_image_button.pressed.connect(func(): _ir_para("Correr"))
	
<<<<<<< HEAD
	# Imprime as informações salvas no console
=======
	_instanciar_visual_do_jogador()
	
	# Opcional: Imprime as informações salvas no console para verificação
>>>>>>> be149d61e6375892048ca711c0d1dde457a49a9e
	print("--- Tela Principal Carregada ---")
	print("Jogador: " + PlayerData.player_name)
	print("Carro selecionado: " + PlayerData.selected_car)
	print("Personagem: " + PlayerData.selected_character)
	
	# Chama as funções para configurar a tela
	_carregar_visual_personagem()
	_animar_botao_correr()
# 
# A Função _ready() TERMINA AQUI
# -------------------------------------------------------------------

<<<<<<< HEAD

# -------------------------------------------------------------------
# A Função _ir_para() COMEÇA AQUI
# -------------------------------------------------------------------
=======
func _instanciar_visual_do_jogador():
	# 1. Cria a instância
	player_visual_instance = PLAYER_VISUAL_CENA.instantiate()
	
	# 2. Adiciona como filho da Tela Principal
	# Adicionar a um nó que garanta a centralização é o ideal (ex: um CenterContainer que você adicionou)
	# Exemplo: Adicionando diretamente ao nó raiz (Control)
	add_child(player_visual_instance)
	
	# 3. Posiciona o visual (ajuste este valor para o meio da sua tela)
	# player_visual_instance.global_position = Vector2(480, 250) # Exemplo de posição (meio da tela)
	
	# Se você adicionou um CenterContainer (como no Passo 16.1), adicione a ele
	var carro_sprite_node: Sprite2D = player_visual_instance.get_node("CarroSprite")
	var personagem_sprite_node: Sprite2D = player_visual_instance.get_node("PersonagemSprite")
	
	player_visual_instance.remove_child(carro_sprite_node)
	player_visual_instance.remove_child(personagem_sprite_node)
	
	container_car.add_child(carro_sprite_node)
	container_character.add_child(personagem_sprite_node)
	
	player_visual_instance.queue_free()
	
	carro_sprite_node.position = Vector2.ZERO
	personagem_sprite_node.position = Vector2.ZERO
	
	# player_visual_instance.position = Vector2.ZERO # Posição zero relativa ao CenterContainer

# Função centralizada para lidar com a navegação para outras cenas
>>>>>>> be149d61e6375892048ca711c0d1dde457a49a9e
func _ir_para(destino: String):
	var caminho_cena: String = ""
	match destino:
		"Garagem":
			caminho_cena = "res://Scenes/TelaGaragem.tscn"
		"Correr":
			caminho_cena = "res://Scenes/TelaSelecaoMapa.tscn" 
		"Configuracao":
			print("Navegando para Configuração (Cena a ser criada).")
			return 
		"Loja":
			print("Navegando para Loja (Cena a ser criada).")
			return
		_:
			print("Erro de navegação: Destino desconhecido: " + destino)
			return

	get_tree().change_scene_to_file(caminho_cena)
#
# A Função _ir_para() TERMINA AQUI
# -------------------------------------------------------------------


# -------------------------------------------------------------------
# A Função _carregar_visual_personagem() COMEÇA AQUI
# -------------------------------------------------------------------
func _carregar_visual_personagem():
	var personagem_escolhido: String = PlayerData.selected_character
	
	if personagem_escolhido == "Mika":
		# Carrega a imagem da Mika
		personagem_sprite.texture = load("res://Objects/Personagem_Mika.png")
	elif personagem_escolhido == "Allan":
		# Carrega a imagem do Allan
		personagem_sprite.texture = load("res://Objects/Personagem_Allan.png")
	else:
		# Se, por algum motivo, nenhum personagem foi selecionado
		print("AVISO: Nenhum personagem selecionado. Escondendo o sprite.")
		personagem_sprite.visible = false # Esconde o nó
#
# A Função _carregar_visual_personagem() TERMINA AQUI
# -------------------------------------------------------------------


# -------------------------------------------------------------------
# A Função _animar_botao_correr() COMEÇA AQUI
# -------------------------------------------------------------------
func _animar_botao_correr():
	# 1. Guarda a posição original para onde o botão deve voltar
	correr_button_pos_original = correr_image_button.position

	# 2. Cria um Tween (gerenciador de animação)
	var tween = create_tween()
	
	# 3. Define o loop para que a animação nunca pare
	tween.set_loops() 
	
	# 4. Define a animação:
	# (Move 10 pixels para a direita em 0.5 segundos)
	tween.tween_property(
		correr_image_button, # O alvo
		"position:x", # A propriedade (apenas o eixo X)
		correr_button_pos_original.x + 10, # O destino
		0.5 # Duração
	).set_trans(Tween.TRANS_SINE) # Transição suave

	# (Move de volta para a posição original em 0.5 segundos)
	tween.tween_property(
		correr_image_button, 
		"position:x", 
		correr_button_pos_original.x, 
		0.5
	).set_trans(Tween.TRANS_SINE)
	
	# (Espera 0.3 segundos antes de recomeçar o loop)
	tween.tween_interval(0.3)
#
# A Função _animar_botao_correr() TERMINA AQUI
# -------------------------------------------------------------------
