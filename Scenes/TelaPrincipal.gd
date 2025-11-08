# TelaPrincipal.gd
extends Control

# --- REFERÊNCIAS DOS BOTÕES ---
# (Nomes e tipos ajustados para bater com a cena)
@onready var garagem_image_button: TextureButton = $GaragemButton 
@onready var configuracao_button: TextureButton = $ConfigButton
@onready var loja_button: TextureButton = $LojaButton
@onready var correr_image_button: TextureButton = $CorrerButton
@onready var dinheiro_label: Label = $DinheiroLabel

# --- REFERÊNCIAS VISUAIS ---
# (Nome ajustado para bater com a cena)
@onready var personagem_sprite: TextureRect = $PersonagemSprite

# --- VARIÁVEIS DE ANIMAÇÃO ---
var correr_button_pos_original: Vector2

# -------------------------------------------------------------------
# A Função _ready() COMEÇA AQUI
# -------------------------------------------------------------------
func _ready():
	# Conecta os botões do menu
	garagem_image_button.pressed.connect(func(): _ir_para("Garagem")) 
	configuracao_button.pressed.connect(func(): _ir_para("Configuracao"))
	loja_button.pressed.connect(func(): _ir_para("Loja"))
	correr_image_button.pressed.connect(func(): _ir_para("Correr"))
	
	# Imprime as informações salvas no console
	print("--- Tela Principal Carregada ---")
	print("Jogador: " + PlayerData.player_name)
	print("Personagem: " + PlayerData.selected_character)
	
	# Chama as funções para configurar a tela
	_carregar_visual_personagem()
	_animar_botao_correr()
	_atualizar_dinheiro_label()
# 
# A Função _ready() TERMINA AQUI
# -------------------------------------------------------------------


# -------------------------------------------------------------------
# A Função _ir_para() COMEÇA AQUI
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
	# Esta é a função que carrega Mika ou Allan
	var personagem_escolhido: String = PlayerData.selected_character
	
	if personagem_escolhido == "Mika":
		# AJUSTE: Caminho corrigido para a pasta "Personagens"
		personagem_sprite.texture = load("res://Objects/Personagens/Personagem_Mika.png")
	elif personagem_escolhido == "Allan":
		# AJUSTE: Caminho corrigido para a pasta "Personagens"
		personagem_sprite.texture = load("res://Objects/Personagens/Personagem_Allan.png")
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

# -------------------------------------------------------------------
# A Função _atualizar_dinheiro_label() COMEÇA AQUI
# -------------------------------------------------------------------
func _atualizar_dinheiro_label():
	# 1. Pega o valor do Singleton
	var dinheiro_atual: int = PlayerData.player_money

	# 2. Formata o texto para ficar igual ao seu design ($ 1200,00)
	#    str() transforma o número 1200 na string "1200"
	dinheiro_label.text = "$ " + str(dinheiro_atual) + ",00"
#
# A Função _atualizar_dinheiro_label() TERMINA AQUI
# -------------------------------------------------------------------
