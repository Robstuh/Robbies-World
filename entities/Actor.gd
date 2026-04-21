class_name Actor
extends CharacterBody2D

@export var display_name: String = "Actor"
@export var max_hp: int = 100
@export var hp: int = 100
@export var attack: int = 10
@export var defense: int = 5
@export var speed: int = 100
@export var level: int = 1
@export var exp: int = 0
@export var exp_to_next: int = 100

signal leveled_up(new_level)
signal exp_gained(amount)

func apply_damage(amount: int, source: Node = null) -> void:
    var final = max(amount - defense, 1)
    hp = clamp(hp - final, 0, max_hp)
    EventBus.actor_damaged.emit(self, final, source)
    if hp <= 0:
        emit_signal("died", self)
        EventBus.actor_died.emit(self)

func is_alive() -> bool:
    return hp > 0

func gain_exp(amount: int) -> void:
    exp += amount
    emit_signal("exp_gained", amount)
    while exp >= exp_to_next:
        exp -= exp_to_next
        level += 1
        exp_to_next = level * 100  # simple formula
        max_hp += 10
        hp = max_hp
        attack += 2
        defense += 1
        emit_signal("leveled_up", level)
