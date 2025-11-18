# TelaGaragem.gd
extends Control

# --- DADOS DO CARROSSEL ---
const CARROS: Array[String] = ["gol", "fusca"] # Nomes internos dos carros
var indice_carro_atual: int = 0 # Índice na lista 'CARROS'

# --- CORES E CONSTANTES ---
const COR_VERMELHA: Color = Color(1.0, 0.0, 0.0) 
const COR_AZUL: Color = Color(0.0, 0.0, 1.0)     
const COR_VERDE: Color = Color(0.0, 1.0, 0.0)


@onready var seta_esquerda_button: Button = $VBoxContainer/HBoxContainer/SetaEsquerdaButton
@onready var seta_direita_button: Button = $VBoxContainer/HBoxContainer/SetaDireitaButton
@onready var carro_atual_label: Label = $VBoxContainer/HBoxContainer/CarroAtualLabel # Onde o nome do carro é exibido

# Referências aos botões de cor e outros botões
@onready var cor_vermelho_button: Button = $VBoxContainer2/HBoxContainer/VermelhoButton # Ajuste o caminho do nó conforme a sua estrutura
@onready var cor_azul_button: Button = $VBoxContainer2/HBoxContainer/AzulButton
@onready var cor_verde_button: Button = $VBoxContainer2/HBoxContainer/VerdeButton
@onready var voltar_button: Button = $VBoxContainer2/VoltarButton

func _ready():
	# 1. CONEXÕES DO CARROSSEL
	seta_esquerda_button.pressed.connect(func(): _mudar_carro(-1))
	seta_direita_button.pressed.connect(func(): _mudar_carro(1))
	
	# Define o estado inicial baseado no PlayerData (caso o jogador volte para a Garagem)
	_carregar_carro_inicial()
	
	# Conecta os botões de cor, passando a cor correspondente
	cor_vermelho_button.pressed.connect(func(): _selecionar_cor(COR_VERMELHA))
	cor_azul_button.pressed.connect(func(): _selecionar_cor(COR_AZUL))
	cor_verde_button.pressed.connect(func(): _selecionar_cor(COR_VERDE))
	
	# Conecta o botão de Voltar
	voltar_button.pressed.connect(_on_voltar_button_pressed)
	
	# Opcional: Mostra o estado atual da cor
	print("Cor atual do carro (RGB): " + str(PlayerData.car_color))

# Função para selecionar e salvar a cor do carro
func _selecionar_cor(nova_cor: Color):
	# 1. Armazenar no Singleton: Salvar a cor globalmente
	PlayerData.car_color = nova_cor
	print("Nova cor do carro selecionada e salva: " + str(nova_cor))
	
	# Nota: Em um jogo real, você usaria essa cor para mudar a aparência 
	# de um Sprite ou Mesh do carro aqui.

# Função para o botão "Voltar para Principal"
func _on_voltar_button_pressed():
	# 1. Navegação: Mudar para a Tela Principal
	get_tree().change_scene_to_file("res://Scenes/TelaPrincipal.tscn")
	print("Voltando para o Menu Principal.")

# Função de simulação para o botão "Alterar Carro"
func _on_alterar_carro_button_pressed():
	print("Funcionalidade de Alterar Carro acionada (em desenvolvimento).")
	# Futuramente, você adicionaria a lógica para trocar o modelo do carro.

func _carregar_carro_inicial():
	# Procura o índice do carro salvo no PlayerData
	var carro_salvo = PlayerData.selected_car
	if CARROS.has(carro_salvo):
		indice_carro_atual = CARROS.find(carro_salvo)
	
	# Atualiza a exibição e salva o carro, garantindo que o estado está correto
	_atualizar_exibicao_carro()

# Função para mudar de carro (Carrossel)
func _mudar_carro(direcao: int):
	# Calcula o novo índice, usando a operação 'wrap' (módulo) para garantir o loop
	# Se 'direcao' for 1 (direita), 'indice_carro_atual' aumenta.
	# Se 'direcao' for -1 (esquerda), 'indice_carro_atual' diminui.
	
	# O tamanho total da lista é usado para o cálculo de módulo (CARROS.size())
	indice_carro_atual = (indice_carro_atual + direcao) % CARROS.size()
	
	# Garante que o índice não seja negativo (Python/Godot lida bem com % de negativos, mas esta é uma garantia)
	if indice_carro_atual < 0:
		indice_carro_atual += CARROS.size()
		
	_atualizar_exibicao_carro()

# Atualiza o nome exibido na tela e salva a escolha no PlayerData
func _atualizar_exibicao_carro():
	var novo_carro: String = CARROS[indice_carro_atual]
	
	# 1. Atualiza a exibição visual (o nome no Label)
	carro_atual_label.text = novo_carro.capitalize() # Mostra "Gol" ou "Fusca"
	
	# 2. Salvar no Singleton: Armazena o nome interno ("gol" ou "fusca")
	PlayerData.selected_car = novo_carro
	print("Carro selecionado salvo: " + PlayerData.selected_car)

# -------------------------------------------------------------------
# Documentação:
# 1. const COR_...: Define constantes do tipo 'Color' para facilitar o uso.
# 2. _ready(): Conecta os botões. Note que a função de cor usa o argumento 'COR_...'
#    diretamente no 'connect'.
# 3. _selecionar_cor(nova_cor: Color): Recebe a cor selecionada e a atribui a 
#    'PlayerData.car_color', tornando-a acessível no cenário de corrida.
# 4. _on_voltar_button_pressed(): Usa o mesmo comando de navegação 'change_scene_to_file' 
#    para retornar ao Menu Principal.
# -------------------------------------------------------------------
