extends Node

var manager: QuestManager = QuestManager.new()

func _ready() -> void:
    EventBus.connect("request_quest_progress", Callable(self, "_on_request_quest_progress"))

func _on_request_quest_progress(quest_id: String, amount: int = 1) -> void:
    manager.progress_quest(quest_id, amount)

func start_quest(quest_id: String) -> void:
    manager.start_quest(quest_id)

func get_active_quests() -> Array:
    return manager.get_active_quests()