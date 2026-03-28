extends CanvasLayer

@export var label_path: NodePath = "Label"
var label
var active_dialogue: Array[String] = []
var index: int = 0
var active_npc: Node = null

func _ready() -> void:
    label = get_node(label_path)
    hide()
    EventBus.connect("request_dialogue", Callable(self, "_on_request_dialogue"))

func _on_request_dialogue(payload) -> void:
    if payload.empty():
        return
    var npc = payload[0]
    if not npc or not npc.has_method("get_dialogue"):
        return
    active_dialogue = npc.get_dialogue()
    active_npc = npc
    index = 0
    if active_dialogue.empty():
        return
    text = active_dialogue[index]
    label.text = text
    show()

func _input(event):
    if not is_visible():
        return
    if event.is_action_pressed("ui_accept"):
        index += 1
        if index >= active_dialogue.size():
            hide()
            EventBus.request_return_to_exploration.emit()
            if active_npc and active_npc.quest_id != "":
                EventBus.request_quest_progress.emit(active_npc.quest_id, 1)
            active_npc = null
            return
        label.text = active_dialogue[index]
