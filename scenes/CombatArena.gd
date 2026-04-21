extends Node2D

var combatants = []
var current_turn = 0
var player
var enemies = []

func _ready() -> void:
    player = GameState.player_scene.instantiate()
    player.position = Vector2(100, 200)
    $PlayerGroup.add_child(player)
    
    for enemy_data in GameState.enemy_list:
        var enemy_inst = load("res://scenes/Enemy.tscn").instantiate()
        enemy_inst.position = Vector2(300 + enemies.size() * 50, 200)
        enemy_inst.display_name = enemy_data.display_name
        enemy_inst.max_hp = enemy_data.max_hp
        enemy_inst.hp = enemy_data.hp
        enemy_inst.attack = enemy_data.attack
        enemy_inst.defense = enemy_data.defense
        $EnemyGroup.add_child(enemy_inst)
        enemies.append(enemy_inst)
    
    combatants = [player] + enemies
    start_turn()

func start_turn():
    if combatants.size() <= 1:
        return
    var current = combatants[current_turn % combatants.size()]
    if current == player:
        show_player_actions()
    else:
        enemy_action(current)

func show_player_actions():
    # For now, auto attack
    if enemies.size() > 0:
        attack(player, enemies[0])
    next_turn()

func enemy_action(enemy):
    attack(enemy, player)
    next_turn()

func attack(attacker, target):
    var damage = max(attacker.attack - target.defense, 1)
    target.hp -= damage
    print(attacker.display_name, " attacks ", target.display_name, " for ", damage, " damage")
    if target.hp <= 0:
        combatants.erase(target)
        target.queue_free()
        if target == player:
            print("Player defeated!")
            get_tree().change_scene_to_file("res://scenes/Main.tscn")
        else:
            enemies.erase(target)
            if enemies.empty():
                print("Victory!")
                get_tree().change_scene_to_file("res://scenes/Main.tscn")

func next_turn():
    current_turn += 1
    start_turn()