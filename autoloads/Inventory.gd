extends Node

class_name Inventory

var items: Dictionary = {}  # item_id -> {item: Item, count: int}

signal item_added(item_id, count)
signal item_removed(item_id, count)

func add_item(item: Item, count: int = 1) -> void:
    if not item.id in items:
        items[item.id] = {"item": item, "count": 0}
    items[item.id]["count"] += count
    emit_signal("item_added", item.id, count)

func remove_item(item_id: String, count: int = 1) -> bool:
    if not item_id in items or items[item_id]["count"] < count:
        return false
    items[item_id]["count"] -= count
    if items[item_id]["count"] <= 0:
        items.erase(item_id)
    emit_signal("item_removed", item_id, count)
    return true

func has_item(item_id: String, count: int = 1) -> bool:
    return item_id in items and items[item_id]["count"] >= count

func get_item_count(item_id: String) -> int:
    if item_id in items:
        return items[item_id]["count"]
    return 0

func get_all_items() -> Array:
    return items.values()