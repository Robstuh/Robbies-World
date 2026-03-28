class_name Actor
extends CharacterBody2D

@export var display_name: String = "Actor"
@export var max_hp: int = 100
@export var hp: int = 100
@export var attack: int = 10
@export var defense: int = 5
@export var speed: int = 100

signal died(actor)

func apply_damage(amount: int, source: Node = null) -> void:
    var final = max(amount - defense, 1)
    hp = clamp(hp - final, 0, max_hp)
    EventBus.actor_damaged.emit(self, final, source)
    if hp <= 0:
        emit_signal("died", self)
        EventBus.actor_died.emit(self)

func is_alive() -> bool:
    return hp > 0
