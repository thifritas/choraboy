# TelaLoja.gd
extends Control

# --- DADOS INTERNOS ---
const CARROS: Array[String] = ["gol quadrado", "fusca"] # Nomes internos dos carros
var indice_carro_atual: int = 0

# --- REFERÊNCIAS ---
# Carrossel
@onready var nome_carro_label: Label = $NomeCarroLabel
@onready var seta_esquerda_button: Button = $SetaEsquerdaButton
@onready var seta_direita_button: Button = $SetaDireitaButton

# Status e Compra
@onready var status_compra_label: Label = $StatusCompraLabel
@onready var comprar_button: Button = $ComprarButton
@onready var voltar_button: Button = $VoltarButton

# Barras de Atributos (ProgressBar)
@onready var velocidade_bar: ProgressBar = $VelocidadeBar
@onready var frenagem_bar: ProgressBar = $FrenagemBar
@onready var peso_bar: ProgressBar = $PesoBar
@onready var resistencia_bar: ProgressBar = $ResistenciaBar

func _ready():
	# 1. Configurar Carrossel e Voltar
	seta_esquerda_button.pressed.connect(func(): _mudar_carro(-1))
	seta_direita_button.pressed.connect(func(): _mudar_carro(1))
	voltar_button.pressed.connect(_on_voltar_button_pressed)
	
	# 2. Conexão do Botão de Compra
	comprar_button.pressed.connect(_on_comprar_button_pressed)
	
	# 3. Inicialização
	_atualizar_carrossel()


# --- LÓGICA DO CARROSSEL ---

func _mudar_carro(direcao: int):
	# Lógica de loop (similar à Garagem)
	indice_carro_atual = (indice_carro_atual + direcao) % CARROS.size()
	if indice_carro_atual < 0:
		indice_carro_atual += CARROS.size()
		
	_atualizar_carrossel()


func _atualizar_carrossel():
	var carro_atual_nome_interno: String = CARROS[indice_carro_atual]
	var is_comprado: bool = PlayerData.car_ownership.get(carro_atual_nome_interno, false)
	
	# 1. Atualiza Nome do Carro
	nome_carro_label.text = carro_atual_nome_interno.capitalize()
	
	# 2. Atualiza Status de Compra e Botão
	_atualizar_status_compra(carro_atual_nome_interno, is_comprado)
	
	# 3. Atualiza Barras de Atributos
	_atualizar_barras_atributos(carro_atual_nome_interno)


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
	
	velocidade_bar.value = atributos.velocidade
	frenagem_bar.value = atributos.frenagem
	peso_bar.value = atributos.peso
	resistencia_bar.value = atributos.resistencia


func _atualizar_status_compra(carro_nome: String, is_comprado: bool):
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
		comprar_button.disabled = true
		comprar_button.text = "COMPRADO (Inicial)"


# --- LÓGICA DE COMPRA ---

func _on_comprar_button_pressed():
	var carro_a_comprar: String = CARROS[indice_carro_atual]
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


# --- NAVEGAÇÃO ---

func _on_voltar_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/TelaPrincipal.tscn")
	print("Voltando para o Menu Principal.")

# -------------------------------------------------------------------
# Documentação do TelaLoja.gd:
# 1. CARROS: Lista dos carros para controlar o carrossel.
# 2. _atualizar_carrossel(): Função principal que coordena as atualizações.
# 3. _atualizar_barras_atributos(): Obtém os valores de 0.0 a 1.0 do PlayerData.CAR_ATTRIBUTES e define o 'value' das ProgressBars.
# 4. _atualizar_status_compra(): Verifica 'PlayerData.car_ownership' e ajusta o texto e o estado 'disabled' do botão de compra.
# 5. _on_comprar_button_pressed(): Lógica onde o carro é marcado como 'true' no dicionário 'car_ownership' e a tela é atualizada.
# -------------------------------------------------------------------
