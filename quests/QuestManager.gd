extends Node

class_name QuestManager

@export var quests: Array[Quest] = []

signal quest_started(quest_id)
signal quest_updated(quest_id)
signal quest_completed(quest_id)

func start_quest(quest_id: String) -> void:
    var q = get_quest(quest_id)
    if not q:
        return
    q.reset()
    emit_signal("quest_started", quest_id)

func complete_quest(quest_id: String) -> void:
    var q = get_quest(quest_id)
    if not q:
        return
    q.completed = true
    emit_signal("quest_completed", quest_id)

func progress_quest(quest_id: String, amount: int = 1) -> void:
    var q = get_quest(quest_id)
    if not q or q.completed:
        return
    q.progress(amount)
    emit_signal("quest_updated", quest_id)
    if q.completed:
        emit_signal("quest_completed", quest_id)

func get_quest(quest_id: String) -> Quest:
    for q in quests:
        if q.id == quest_id:
            return q
    return null

func get_active_quests() -> Array:
    return quests.filter(lambda q: not q.completed)
