# TelaCadastroNome.gd
extends Control

# Variáveis para referenciar os nós (componentes visuais)
# Você deve atribuir esses nós no Inspector da Godot (arrastando-os para cá)
@onready var nome_input: LineEdit = $LineEdit
@onready var proximo_button: Button = $Button

# Sinal que será chamado quando o botão "Próximo" for pressionado
func _ready():
	# Conecta a ação de pressionar o botão à função '_on_proximo_button_pressed'
	proximo_button.pressed.connect(_on_proximo_button_pressed)

# Função chamada quando o jogador pressiona o botão "Próximo"
func _on_proximo_button_pressed():
	var nome_digitado: String = nome_input.text.strip_edges()
	
	# 1. Verificação (Restrição): O nome não pode estar vazio!
	if nome_digitado.is_empty():
		print("Atenção: Por favor, digite um nome para continuar.")
		# Opcional: Adicionar um pop-up de erro visual aqui.
		return
		
	# 2. Armazenar no Singleton: Salvar o nome globalmente
	PlayerData.player_name = nome_digitado
	print("Nome do jogador salvo: " + PlayerData.player_name)
	
	# 3. Navegação: Mudar para a próxima tela (Seleção de Personagem)
	# OBS: Substitua "res://Scenes/TelaSelecaoPersonagem.tscn" pelo caminho real 
	# da cena que criaremos a seguir.
	
	# Exemplo simples de navegação:
	get_tree().change_scene_to_file("res://Scenes/TelaSelecaoPersonagem.tscn")

# -------------------------------------------------------------------
# Documentação:
# 1. @onready var nome_input: Acessa o nó LineEdit para ler o texto.
# 2. _ready(): Conecta o sinal 'pressed' do botão a uma função.
# 3. _on_proximo_button_pressed(): Lógica principal.
# 4. nome_input.text.strip_edges(): Pega o texto e remove espaços extras.
# 5. PlayerData.player_name = nome_digitado: A chave! Salva a informação globalmente.
# 6. get_tree().change_scene_to_file: É o método da Godot para mudar de tela.
# -------------------------------------------------------------------
