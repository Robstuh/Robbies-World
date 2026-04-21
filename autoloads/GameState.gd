extends Node

enum Mode { EXPLORATION, COMBAT, DIALOGUE, PAUSED, MENU }
var current_mode: Mode = Mode.EXPLORATION
var player_scene: PackedScene = preload("res://scenes/Player.tscn")
var current_player: Node = null
var enemy_list = []
var player_data = {}

func _ready():
    EventBus.connect("request_enter_combat", Callable(self, "_on_request_enter_combat"))
    EventBus.connect("request_return_to_exploration", Callable(self, "_on_request_return_to_exploration"))
    EventBus.connect("request_dialogue", Callable(self, "_on_request_dialogue"))
    EventBus.connect("actor_died", Callable(self, "_on_actor_died"))

func _on_actor_died(actor):
    if actor is Enemy and current_player:
        current_player.gain_exp(50)

func _on_request_enter_combat(enemies):
    self.enemy_list = []
    for enemy in enemies:
        var data = {
            "display_name": enemy.display_name,
            "max_hp": enemy.max_hp,
            "hp": enemy.hp,
            "attack": enemy.attack,
            "defense": enemy.defense,
            "level": enemy.level,
            "exp": enemy.exp,
            "exp_to_next": enemy.exp_to_next
        }
        self.enemy_list.append(data)
    if current_player:
        player_data = {
            "display_name": current_player.display_name,
            "max_hp": current_player.max_hp,
            "hp": current_player.hp,
            "attack": current_player.attack,
            "defense": current_player.defense,
            "level": current_player.level,
            "exp": current_player.exp,
            "exp_to_next": current_player.exp_to_next
        }
    current_mode = Mode.COMBAT
    get_tree().change_scene_to_file("res://scenes/CombatArena.tscn")

func _on_request_return_to_exploration():
    current_mode = Mode.EXPLORATION
    get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_request_dialogue(actor_id):
    current_mode = Mode.DIALOGUE

func pause_game():
    current_mode = Mode.PAUSED
    get_tree().paused = true

func resume_game():
    get_tree().paused = false
    current_mode = Mode.EXPLORATION
