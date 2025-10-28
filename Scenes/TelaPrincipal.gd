# TelaPrincipal.gd
extends Control

# Referências aos botões
@onready var garagem_button: Button = $VBoxContainer/GaragemButton  # Ajuste os nomes dos nós conforme sua estrutura
@onready var configuracao_button: Button = $VBoxContainer/ConfiguracaoButton
@onready var loja_button: Button = $VBoxContainer/LojaButton
@onready var correr_button: Button = $VBoxContainer/CorrerButton

func _ready():
	# Conecta todos os botões a uma função de navegação, passando o destino
	garagem_button.pressed.connect(func(): _ir_para("Garagem"))
	configuracao_button.pressed.connect(func(): _ir_para("Configuracao"))
	loja_button.pressed.connect(func(): _ir_para("Loja"))
	correr_button.pressed.connect(func(): _ir_para("Correr"))
	
	# Opcional: Imprime as informações salvas no console para verificação
	print("--- Tela Principal Carregada ---")
	print("Jogador: " + PlayerData.player_name)
	print("Personagem: " + PlayerData.selected_character)

# Função centralizada para lidar com a navegação para outras cenas
func _ir_para(destino: String):
	var caminho_cena: String = ""
	
	match destino:
		"Garagem":
			caminho_cena = "res://Scenes/TelaGaragem.tscn"
			# O próximo passo é criar esta cena
		"Correr":
			caminho_cena = "res://Scenes/TelaSelecaoMapa.tscn"
			# Pulamos a tela de corrida e vamos direto para a seleção de mapa
		"Configuracao":
			# Scene temporária, pois você não especificou o conteúdo ainda
			print("Navegando para Configuração (Cena a ser criada).")
			# caminho_cena = "res://Scenes/TelaConfiguracao.tscn" 
			return # Apenas para fins de teste, se a cena não existir
		"Loja":
			# Scene temporária
			print("Navegando para Loja (Cena a ser criada).")
			# caminho_cena = "res://Scenes/TelaLoja.tscn"
			return # Apenas para fins de teste, se a cena não existir
		_:
			print("Erro de navegação: Destino desconhecido: " + destino)
			return
			
	# Executa a troca de cena se o caminho não estiver vazio
	get_tree().change_scene_to_file(caminho_cena)

# -------------------------------------------------------------------
# Documentação:
# 1. @onready var ...: Acessa os botões. Lembre-se de nomeá-los de forma clara 
#    no editor Godot (ex: GaragemButton, CorrerButton).
# 2. _ready(): Conecta a ação de pressionar cada botão à função '_ir_para()', 
#    passando o nome da próxima tela como argumento.
# 3. _ir_para(destino: String): Função de navegação com a estrutura 'match' (similar ao switch). 
#    Isso torna o código limpo, pois só precisamos de uma função para todos os botões.
# 4. get_tree().change_scene_to_file(): O comando final para carregar a nova cena.
# -------------------------------------------------------------------
