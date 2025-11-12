extends Control

# --- REFERÊNCIAS DOS BOTÕES ---
@onready var garagem_image_button: TextureButton = $GaragemButton
@onready var configuracao_button: TextureButton = $ConfigButton
@onready var loja_button: TextureButton = $LojaButton
@onready var correr_image_button: TextureButton = $CorrerButton
@onready var dinheiro_label: Label = $DinheiroLabel

# --- REFERÊNCIAS VISUAIS ---
@onready var personagem_sprite: TextureRect = $PersonagemSprite

### AJUSTADO: REFERÊNCIAS DO CARRO ###
# (Assumindo que estão DENTRO do CarContainer)
@onready var car_container: Control = $CarContainer
@onready var chassis: TextureRect = $CarContainer/Chassis
@onready var roda_frente: TextureRect = $CarContainer/RodaFrente
@onready var roda_tras: TextureRect = $CarContainer/RodaTras

# --- VARIÁVEIS DE ANIMAÇÃO ---
var correr_button_pos_original: Vector2

### VARIÁVEIS DE ANIMAÇÃO DO CARRO ###
var is_car_moving: bool = false
var rotation_speed: float = 360.0 
### FIM AJUSTADO ###


# -------------------------------------------------------------------
# A Função _ready() COMEÇA AQUI
# -------------------------------------------------------------------
func _ready():
	# Conecta os botões do menu
	garagem_image_button.pressed.connect(func(): _ir_para("Garagem"))
	configuracao_button.pressed.connect(func(): _ir_para("Configuracao"))
	loja_button.pressed.connect(func(): _ir_para("Loja"))
	correr_image_button.pressed.connect(func(): _ir_para("Correr"))
	
	# Configura a tela
	_carregar_visual_personagem()
	_animar_botao_correr()
	_atualizar_dinheiro_label()
	
	### Inicia a animação do carro ###
	_animar_carro_entrada()
# 
# A Função _ready() TERMINA AQUI
# -------------------------------------------------------------------


### A Função _process() COMEÇA AQUI ###
func _process(delta):
	# Se o carro estiver em movimento, gira as rodas
	if is_car_moving:
		roda_frente.rotation_degrees += rotation_speed * delta
		roda_tras.rotation_degrees += rotation_speed * delta
#
# A Função _process() TERMINA AQUI
# -------------------------------------------------------------------


# -------------------------------------------------------------------
# A Função _ir_para() COMEÇA AQUI
# (Sem alterações)
# -------------------------------------------------------------------
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
			# Certifica-te que este é o nome correto da tua cena da Loja
			caminho_cena = "res://Scenes/TelaLoja.tscn"
		_:
			print("Erro de navegação: Destino desconhecido: " + destino)
			return
	get_tree().change_scene_to_file(caminho_cena)
#
# A Função _ir_para() TERMINA AQUI
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# A Função _carregar_visual_personagem() COMEÇA AQUI
# (Sem alterações)
# -------------------------------------------------------------------
func _carregar_visual_personagem():
	var personagem_escolhido: String = PlayerData.selected_character
	if personagem_escolhido == "Mika":
		personagem_sprite.texture = load("res://Objects/Personagens/Personagem_Mika.png")
	elif personagem_escolhido == "Allan":
		personagem_sprite.texture = load("res://Objects/Personagens/Personagem_Allan.png")
	else:
		print("AVISO: Nenhum personagem selecionado. Escondendo o sprite.")
		personagem_sprite.visible = false
#
# A Função _carregar_visual_personagem() TERMINA AQUI
# -------------------------------------------------------------------


# -------------------------------------------------------------------
# A Função _animar_botao_correr() COMEÇA AQUI
# (Sem alterações)
# -------------------------------------------------------------------
func _animar_botao_correr():
	correr_button_pos_original = correr_image_button.position
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(
		correr_image_button, "position:x", correr_button_pos_original.x + 10, 0.5
	).set_trans(Tween.TRANS_SINE)
	tween.tween_property(
		correr_image_button, "position:x", correr_button_pos_original.x, 0.5
	).set_trans(Tween.TRANS_SINE)
	tween.tween_interval(0.3)
#
# A Função _animar_botao_correr() TERMINA AQUI
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# A Função _atualizar_dinheiro_label() COMEÇA AQUI
# (Sem alterações)
# -------------------------------------------------------------------
func _atualizar_dinheiro_label():
	var dinheiro_atual: int = PlayerData.player_money
	dinheiro_label.text = "$ " + str(dinheiro_atual) + ",00"
#
# A Função _atualizar_dinheiro_label() TERMINA AQUI
# -------------------------------------------------------------------


### FUNÇÕES DE ANIMAÇÃO DO CARRO ###
# -------------------------------------------------------------------
# 1. Função que inicia a animação
# -------------------------------------------------------------------
func _animar_carro_entrada():
	# 1. Pega a posição FINAL (a que definiste no editor)
	var pos_final_x = car_container.position.x
	
	# 2. Calcular Posição INICIAL
	if car_container.size.x == 0:
		print("AVISO: O 'Size' do CarContainer é 0. A animação pode falhar.")
		print("Ajusta o 'Size' do CarContainer no Inspetor (Layout -> Transform)")
	
	### AJUSTADO AQUI ###
	# Começa na largura do carro, e subtrai mais 200 pixels
	# para começar mais longe da tela.
	var start_pos_x = -car_container.size.x - 400 
	
	# 3. Definir estado inicial
	# Coloca o CARRO INTEIRO (o contentor) na posição inicial
	car_container.position.x = start_pos_x
	is_car_moving = true # Avisa ao _process para começar a girar as rodas
	
	# 4. Criar o Tween (o animador)
	var tween = create_tween()
	
	# 5. Configurar a animação de movimento
	# (A duração de 2.0 segundos continua a mesma, mas a distância
	# a percorrer é maior, o que o fará parecer um pouco mais rápido.)
	tween.tween_property(car_container, "position:x", pos_final_x, 2.0)\
		 .set_trans(Tween.TRANS_CUBIC)\
		 .set_ease(Tween.EASE_OUT)
		 
	# 6. Conectar o sinal de "terminado"
	tween.finished.connect(_on_carro_animacao_terminada)
# -------------------------------------------------------------------
# 2. Função chamada quando a animação de movimento termina
# -------------------------------------------------------------------
func _on_carro_animacao_terminada():
	is_car_moving = false # Para de girar as rodas
	print("Animação do carro principal concluída.")
