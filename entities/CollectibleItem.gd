class_name CollectibleItem
extends Area2D

@export var item: Item
@export var count: int = 1

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
    if body is Player:
        Inventory.add_item(item, count)
        EventBus.item_picked.emit(item.id)
        if item.id == "mushroom":
            EventBus.request_quest_progress.emit("find_mushrooms", count)
        queue_free()