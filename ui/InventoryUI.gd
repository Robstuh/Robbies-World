extends CanvasLayer

@export var item_list_path: NodePath = "ItemList"
var item_list: ItemList

func _ready() -> void:
    item_list = get_node(item_list_path)
    Inventory.connect("item_added", Callable(self, "_on_item_added"))
    Inventory.connect("item_removed", Callable(self, "_on_item_removed"))
    update_display()

func update_display() -> void:
    item_list.clear()
    for item_data in Inventory.get_all_items():
        var item = item_data["item"]
        var count = item_data["count"]
        item_list.add_item(item.name + " x" + str(count), item.icon)

func _on_item_added(item_id, count):
    update_display()

func _on_item_removed(item_id, count):
    update_display()