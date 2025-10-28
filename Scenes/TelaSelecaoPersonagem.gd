# TelaSelecaoPersonagem.gd
extends Control

# Referências aos botões
@onready var mika_button: Button = $HBoxContainer/Button
@onready var allan_button: Button = $HBoxContainer/Button2 # Renomeie o segundo botão para Button2 no editor ou use o nome que ele tiver.

func _ready():
	# Conecta os sinais 'pressed' dos botões às suas respectivas funções
	mika_button.pressed.connect(func(): _selecionar_personagem("Mika"))
	allan_button.pressed.connect(func(): _selecionar_personagem("Allan"))
	
	# Opcional: Mostra o nome do jogador salvo na tela anterior
	print("Bem-vindo(a), " + PlayerData.player_name + "! Selecione um personagem.")


# Função principal para selecionar o personagem e avançar
func _selecionar_personagem(nome_personagem: String):
	# 1. Armazenar no Singleton: Salvar a escolha globalmente
	PlayerData.selected_character = nome_personagem
	print("Personagem selecionado: " + nome_personagem)
	
	# 2. Navegação: Mudar para a próxima tela (Menu Principal)
	# OBS: Você precisará criar a cena "TelaPrincipal.tscn" em seguida.
	get_tree().change_scene_to_file("res://Scenes/TelaPrincipal.tscn")

# -------------------------------------------------------------------
# Documentação:
# 1. @onready var ...: Garante que os nós sejam acessados após o carregamento da cena.
# 2. _ready(): Conecta a ação dos botões. Usamos 'func(): _selecionar_personagem("Mika")'
#    para passar o nome como argumento para a função, tornando-a mais limpa.
# 3. _selecionar_personagem(nome_personagem): Função que recebe o nome.
# 4. PlayerData.selected_character = nome_personagem: Salva a informação no nosso script global.
# 5. get_tree().change_scene_to_file("..."): Navega para o próximo menu.
# -------------------------------------------------------------------
