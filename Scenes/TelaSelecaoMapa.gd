# TelaSelecaoMapa.gd
extends Control

# Referências aos botões de mapa
@onready var sao_paulo_button: Button = $HBoxContainer/SaoPauloButton # Ajuste os nomes dos nós!
@onready var rio_de_janeiro_button: Button = $HBoxContainer/RioDeJaneiroButton
@onready var voltar_button: Button = $VoltarButton

func _ready():
	# Conecta os botões de seleção de mapa
	sao_paulo_button.pressed.connect(func(): _selecionar_mapa("São Paulo"))
	rio_de_janeiro_button.pressed.connect(func(): _selecionar_mapa("Rio de Janeiro"))
	
	# Conecta o botão de Voltar
	voltar_button.pressed.connect(_on_voltar_button_pressed)

# Função principal para selecionar o mapa e avançar
func _selecionar_mapa(nome_mapa: String):
	# 1. Armazenar no Singleton: Salvar a escolha do mapa globalmente
	PlayerData.selected_map = nome_mapa
	print("Mapa selecionado: " + nome_mapa)
	
	# 2. Navegação: Mudar para a próxima tela (Pista de Corrida)
	# OBS: Você precisará criar a cena "TelaPista.tscn" a seguir.
	print("Preparando para carregar a Pista: " + nome_mapa)
	get_tree().change_scene_to_file("res://Scenes/TelaPista.tscn")

# Função para o botão "Voltar para Principal"
func _on_voltar_button_pressed():
	# 1. Navegação: Mudar para a Tela Principal
	get_tree().change_scene_to_file("res://Scenes/TelaPrincipal.tscn")
	print("Voltando para o Menu Principal.")

# -------------------------------------------------------------------
# Documentação:
# 1. _ready(): Conecta os botões, passando o nome completo do mapa (o que será exibido).
# 2. _selecionar_mapa(nome_mapa: String): Recebe o nome, salva em 'PlayerData.selected_map' 
#    e avança para a cena 'TelaPista'.
# 3. _on_voltar_button_pressed(): Retorna para o Menu Principal (TelaPrincipal).
# -------------------------------------------------------------------
