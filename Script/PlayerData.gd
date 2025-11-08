# PlayerData.gd (Singleton/Autoload)
extends Node

# Variáveis globais para armazenar as informações do jogador
var player_name: String = ""
var selected_character: String = "" # Pode ser "Mika" ou "Allan"
var car_color: Color = Color.WHITE # Cor inicial, vamos usar depois
var selected_map: String = "" # Mapa selecionado (São Paulo ou Rio de Janeiro)
var selected_car: String = "gol" # Carro inicial padrão

# Começa o jogador com 1200
var player_money: int = 1200

# -------------------------------------------------------------------
# Documentação:
# 1. extends Node: Singleton não precisa de uma representação visual.
# 2. player_name: Variável para guardar o nome digitado.
# 3. selected_character: Variável para guardar qual dos dois foi escolhido.
# 4. car_color: Guardará a cor personalizada do carro (para o menu "Garagem").
# 5. selected_map: Guardará a escolha de pista (para o menu "Correr").
# -------------------------------------------------------------------
