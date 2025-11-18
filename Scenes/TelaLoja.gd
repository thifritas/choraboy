# TelaLoja.gd
extends Control

# --- DADOS INTERNOS ---
const CARROS: Array[String] = ["gol quadrado", "fusca"] # Nomes internos dos carros
var indice_carro_atual: int = 0
<<<<<<< HEAD
@onready var visual_carro: TextureRect = $Carro

@onready var dinheiro_label: Label = $DinheiroLabel
=======
>>>>>>> f56cf7e86ee3cc6bed412fac0235ab5282cbf038

# --- REFERÊNCIAS ---
# Carrossel
@onready var nome_carro_label: Label = $NomeCarroLabel
@onready var seta_esquerda_button: Button = $SetaEsquerdaButton
@onready var seta_direita_button: Button = $SetaDireitaButton

# Status e Compra
@onready var status_compra_label: Label = $StatusCompraLabel
<<<<<<< HEAD
# Ajuste o caminho conforme sua estrutura real, ex: VBoxContainer/HBoxContainer2/ComprarButton
=======
>>>>>>> f56cf7e86ee3cc6bed412fac0235ab5282cbf038
@onready var comprar_button: Button = $ComprarButton
@onready var voltar_button: Button = $VoltarButton

# Barras de Atributos (ProgressBar)
@onready var velocidade_bar: ProgressBar = $VelocidadeBar
@onready var frenagem_bar: ProgressBar = $FrenagemBar
@onready var peso_bar: ProgressBar = $PesoBar
@onready var resistencia_bar: ProgressBar = $ResistenciaBar

<<<<<<< HEAD
#POPUP erro
@onready var warning_popup_layer: CanvasLayer = $ConfigPopupLayer
@onready var fechar_config_button: TextureButton = $ConfigPopupLayer/Panel/FecharButton

@onready var warning: Label = $ConfigPopupLayer/Panel/ErrorMessage

=======
>>>>>>> f56cf7e86ee3cc6bed412fac0235ab5282cbf038
func _ready():
	# 1. Configurar Carrossel e Voltar
	seta_esquerda_button.pressed.connect(func(): _mudar_carro(-1))
	seta_direita_button.pressed.connect(func(): _mudar_carro(1))
	voltar_button.pressed.connect(_on_voltar_button_pressed)
	
	# 2. Conexão do Botão de Compra
	comprar_button.pressed.connect(_on_comprar_button_pressed)
	
<<<<<<< HEAD
	#garantir que o popup esteja escondido
	fechar_config_button.pressed.connect(_on_fechar_aviso)
	warning_popup_layer.hide()
	
	# 3. Inicialização
	_atualizar_carrossel()
	_atualizar_dinheiro_label()


#Lógica popup

func _on_abrir_aviso():
	warning_popup_layer.show()
	print("Popup de aviso aberto.")

func _on_fechar_aviso():
	warning_popup_layer.hide()
	print("Popup de aviso fechado.")

=======
	# 3. Inicialização
	_atualizar_carrossel()


>>>>>>> f56cf7e86ee3cc6bed412fac0235ab5282cbf038
# --- LÓGICA DO CARROSSEL ---

func _mudar_carro(direcao: int):
	# Lógica de loop (similar à Garagem)
	indice_carro_atual = (indice_carro_atual + direcao) % CARROS.size()
	if indice_carro_atual < 0:
		indice_carro_atual += CARROS.size()
		
	_atualizar_carrossel()


func _atualizar_carrossel():
	var carro_atual_nome_interno: String = CARROS[indice_carro_atual]
<<<<<<< HEAD
	# Retorna o valor de posse ou 'false' se não existir a chave
	var is_comprado: bool = PlayerData.car_ownership.get(carro_atual_nome_interno, false) 
=======
	var is_comprado: bool = PlayerData.car_ownership.get(carro_atual_nome_interno, false)
>>>>>>> f56cf7e86ee3cc6bed412fac0235ab5282cbf038
	
	# 1. Atualiza Nome do Carro
	nome_carro_label.text = carro_atual_nome_interno.capitalize()
	
<<<<<<< HEAD
	if carro_atual_nome_interno == "gol quadrado":
		visual_carro.texture = load("res://Objects/Carro_Gol.png")
	elif carro_atual_nome_interno == "fusca":
		visual_carro.texture = load("res://Assets/Cars/Fusca.png")
	else:
		print("AVISO: Nenhum carro selecionado. Escondendo o sprite.")
		visual_carro.visible = false
	
=======
>>>>>>> f56cf7e86ee3cc6bed412fac0235ab5282cbf038
	# 2. Atualiza Status de Compra e Botão
	_atualizar_status_compra(carro_atual_nome_interno, is_comprado)
	
	# 3. Atualiza Barras de Atributos
	_atualizar_barras_atributos(carro_atual_nome_interno)

<<<<<<< HEAD
# --- LÓGICA DE ATRIBUTOS E STATUS ---

func _atualizar_barras_atributos(carro_nome: String):
	var atributos: Dictionary = PlayerData.CAR_ATTRIBUTES.get(carro_nome, {})
	
	if atributos.is_empty():
		printerr("Erro: Atributos não definidos para o carro: " + carro_nome)
		return
	
	# Configura o range do ProgressBar para 0.0 a 1.0 (ajuste de Stack Overflow)
	# Se já configurado no editor, estas linhas são opcionais, mas seguras.
	velocidade_bar.min_value = 0.0
	velocidade_bar.max_value = 1.0
	frenagem_bar.min_value = 0.0
	frenagem_bar.max_value = 1.0
	peso_bar.min_value = 0.0
	peso_bar.max_value = 1.0
	resistencia_bar.min_value = 0.0
	resistencia_bar.max_value = 1.0
		
	# Define o valor do progresso
=======

# --- LÓGICA DE ATRIBUTOS E STATUS ---

func _atualizar_barras_atributos(carro_nome: String):
	# Obtém o dicionário de atributos do PlayerData
	var atributos: Dictionary = PlayerData.CAR_ATTRIBUTES.get(carro_nome, {})
	
	if atributos.is_empty():
		# Lidar com erro se o carro não tiver atributos definidos
		print("Erro: Atributos não definidos para o carro: " + carro_nome)
		return
		
	# As barras de progresso na Godot usam `value` (valor) e `max_value` (valor máximo).
	# Como definimos os atributos de 0.0 a 1.0, o `max_value` é 1.0 (ou 100).
	
	# É bom configurar as ProgressBars no editor com min_value=0, max_value=1.0.
	
>>>>>>> f56cf7e86ee3cc6bed412fac0235ab5282cbf038
	velocidade_bar.value = atributos.velocidade
	frenagem_bar.value = atributos.frenagem
	peso_bar.value = atributos.peso
	resistencia_bar.value = atributos.resistencia


func _atualizar_status_compra(carro_nome: String, is_comprado: bool):
<<<<<<< HEAD
	# O valor é pego do dicionário estático (CAR_ATTRIBUTES)
	var valor: int = PlayerData.CAR_ATTRIBUTES.get(carro_nome, {}).get("valor", 0)
	
	if is_comprado:
		status_compra_label.text = "COMPRADO"
		comprar_button.disabled = true
		comprar_button.text = "Selecionar (Vá para a Garagem)"
	else:
		status_compra_label.text = "BLOQUEADO"
		comprar_button.disabled = false
		comprar_button.text = "COMPRAR - $" + str(valor)
		
	# Trata o carro inicial
	if carro_nome == "gol quadrado":
=======
	var valor: int = PlayerData.CAR_ATTRIBUTES[carro_nome].valor
	
	if is_comprado:
		status_compra_label.text = "Status: COMPRADO"
		comprar_button.disabled = true
		comprar_button.text = "Selecionar (em Garagem)" # Indica que o carro já é seu
	else:
		status_compra_label.text = "Status: BLOQUEADO"
		comprar_button.disabled = false
		comprar_button.text = "COMPRAR - $" + str(valor) # Mostra o preço
		
	# Carro inicial (Gol) não pode ser comprado, apenas o Fusca.
	if carro_nome == "gol":
>>>>>>> f56cf7e86ee3cc6bed412fac0235ab5282cbf038
		comprar_button.disabled = true
		comprar_button.text = "COMPRADO (Inicial)"


# --- LÓGICA DE COMPRA ---

func _on_comprar_button_pressed():
	var carro_a_comprar: String = CARROS[indice_carro_atual]
<<<<<<< HEAD
	
	var valor_carro: int = PlayerData.CAR_ATTRIBUTES.get(carro_a_comprar, {}).get("valor", 0)
	
	if PlayerData.car_ownership.get(carro_a_comprar, false):
		print("AVISO: Carro já foi comprado.")
		return 
	if PlayerData.player_money >= valor_carro:
		
		# A. TRANSAÇÃO: Subtrair o dinheiro
		PlayerData.player_money -= valor_carro
		
		# B. ATUALIZAR POSSE: Marcar carro como comprado
		PlayerData.car_ownership[carro_a_comprar] = true
		
		print("✅ Compra bem-sucedida!")
		print("Carro comprado: " + carro_a_comprar.capitalize())
		print("Novo Saldo: $" + str(PlayerData.player_money))
		warning.text = "Compra realizada com sucesso"
		_on_abrir_aviso()
		_atualizar_dinheiro_label()
		
	else:
		# C. FALHA NA COMPRA: Saldo Insuficiente
		print("❌ FALHA: Saldo insuficiente!")
		print("Seu Saldo: $" + str(PlayerData.player_money) + ", Preço do Carro: $" + str(valor_carro))
		warning.text = "Saldo insuficiente"
		_on_abrir_aviso()
		
		return # Sai da função
		
	# 2. Atualiza o status de posse global
	PlayerData.car_ownership[carro_a_comprar] = true
	print("Carro comprado com sucesso: " + carro_a_comprar)
	
	# 3. Atualiza a interface, usando call_deferred para EVITAR STACK OVERFLOW
	# Isso garante que a atualização ocorra após o processamento do clique.
	call_deferred("_atualizar_carrossel")
=======
	var valor_carro: int = PlayerData.CAR_ATTRIBUTES[carro_a_comprar].valor
	
	# 1. Simulação de Lógica de Compra
	# OBS: Você precisará de uma variável global para rastrear o dinheiro do jogador!
	# Por enquanto, vamos simular que ele sempre tem dinheiro.
	
	# if PlayerData.player_money >= valor_carro:
	#     PlayerData.player_money -= valor_carro # Subtrai o dinheiro
		
		# 2. Atualiza o status de posse global
	PlayerData.car_ownership[carro_a_comprar] = true
	print("Carro comprado com sucesso: " + carro_a_comprar)
	
	# 3. Atualiza a interface
	_atualizar_carrossel()
	
	# else:
	#    print("Saldo insuficiente para comprar: " + carro_a_comprar)

>>>>>>> f56cf7e86ee3cc6bed412fac0235ab5282cbf038

# --- NAVEGAÇÃO ---

func _on_voltar_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/TelaPrincipal.tscn")
	print("Voltando para o Menu Principal.")
<<<<<<< HEAD
	
func _atualizar_dinheiro_label():
	var dinheiro_atual: int = PlayerData.player_money
	dinheiro_label.text = "$ " + str(dinheiro_atual) + ",00"
=======

# -------------------------------------------------------------------
# Documentação do TelaLoja.gd:
# 1. CARROS: Lista dos carros para controlar o carrossel.
# 2. _atualizar_carrossel(): Função principal que coordena as atualizações.
# 3. _atualizar_barras_atributos(): Obtém os valores de 0.0 a 1.0 do PlayerData.CAR_ATTRIBUTES e define o 'value' das ProgressBars.
# 4. _atualizar_status_compra(): Verifica 'PlayerData.car_ownership' e ajusta o texto e o estado 'disabled' do botão de compra.
# 5. _on_comprar_button_pressed(): Lógica onde o carro é marcado como 'true' no dicionário 'car_ownership' e a tela é atualizada.
# -------------------------------------------------------------------
>>>>>>> f56cf7e86ee3cc6bed412fac0235ab5282cbf038
