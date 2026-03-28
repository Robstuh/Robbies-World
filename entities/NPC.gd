class_name NPC
extends Actor

@export var dialogue_script: Array[String] = []
@export var quest_id: String = ""

signal interact_started(npc, line_index)

func interact() -> void:
    if dialogue_script.empty():
        return
    emit_signal("interact_started", self, 0)
    EventBus.request_dialogue.emit([self])

func get_dialogue() -> Array[String]:
    return dialogue_script
