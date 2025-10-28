# TelaPista.gd
extends Node2D

# Referências aos botões
@onready var acelerar_button: Button = $CanvasLayer/AcelerarButton
@onready var frear_button: Button = $CanvasLayer/FrearButton
@onready var cima_button: Button = $CanvasLayer/CimaButton
@onready var baixo_button: Button = $CanvasLayer/BaixoButton

# Referência ao carro
var carro_node: CharacterBody2D = null

func _ready():
	# 1. Instanciar o Carro na Pista
	var carro_cena = load("res://Objects/Carro.tscn")
	carro_node = carro_cena.instantiate()
	add_child(carro_node)
	
	# 2. Conectar os botões de aceleração/freio (Usa sinais 'pressed' e 'released')
	acelerar_button.pressed.connect(func(): carro_node.set_acelerar(true))
	acelerar_button.released.connect(func(): carro_node.set_acelerar(false))
	
	frear_button.pressed.connect(func(): carro_node.set_frear(true))
	frear_button.released.connect(func(): carro_node.set_frear(false))
	
	# 3. Conectar os botões de faixa (Usa apenas o sinal 'pressed')
	cima_button.pressed.connect(carro_node.ir_para_cima)
	baixo_button.pressed.connect(carro_node.ir_para_baixo)
	
	# 4. Informação do Jogador
	print("--- INICIANDO CORRIDA ---")
	print("Mapa carregado: " + PlayerData.selected_map)
	print("Carro do jogador: " + PlayerData.selected_car + ", Cor: " + str(PlayerData.car_color))
	# Futuramente, a lógica aqui carregaria a pista e o sprite do carro corretos.

# -------------------------------------------------------------------
# Documentação da TelaPista.gd:
# 1. load(...).instantiate() / add_child(): O método padrão da Godot para colocar uma cena (o carro) dentro de outra (a pista).
# 2. Conexões pressed/released: Usadas para botões de ação contínua (acelerar/frear). Enquanto o botão estiver pressionado, a ação é TRUE.
# 3. Conexões pressed: Usadas para ações pontuais (mudar de faixa). A função é chamada uma única vez ao toque.
# -------------------------------------------------------------------
