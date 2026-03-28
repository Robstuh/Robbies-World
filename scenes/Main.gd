extends Node2D

@export var player_scene: PackedScene = preload("res://scenes/Player.tscn")
@export var npc_scene: PackedScene = preload("res://scenes/NPC.tscn")

func _ready() -> void:
    var player = player_scene.instantiate()
    player.position = Vector2(256, 192)
    add_child(player)

    var npc = npc_scene.instantiate()
    npc.position = Vector2(320, 192)
    add_child(npc)

    # this ensures an NPC can be interacted / auto dialog call
    npc.dialogue_script = ["Hello, traveler.", "Can you help me find 5 mushrooms?", "Please collect them and return."]
    npc.quest_id = "find_mushrooms"

    # initialize quest in manager (autoload needed)
    if Engine.has_singleton("QuestSystem"):
        QuestSystem.manager.quests.append(load("res://quests/Quest.gd").new())
        var q = QuestSystem.manager.get_quest("find_mushrooms")
        if not q:
            q = load("res://quests/Quest.gd").new()
            q.id = "find_mushrooms"
            q.title = "Mushroom Hunt"
            q.description = "Collect 5 mushrooms from the forest."
            q.objective_description = "Gather 5 mushrooms"
            q.objective_required = 5
            QuestSystem.manager.quests.append(q)
