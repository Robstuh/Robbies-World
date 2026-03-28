class_name Enemy
extends Actor

func _ready() -> void:
    connect("died", self, "queue_free")

func take_turn(target: Actor) -> void:
    if target and target.is_alive():
        target.apply_damage(attack, self)