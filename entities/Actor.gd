{\rtf1\ansi\ansicpg1252\cocoartf2867
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 class_name Actor\
extends CharacterBody2D\
\
# --- Identity ---\
@export var actor_id: StringName\
@export var display_name: String\
\
# --- Stats (data-driven: override per actor type) ---\
var stats: Dictionary = \{\
    "max_hp": 100,\
    "hp": 100,\
    "max_mp": 50,\
    "mp": 50,\
    "strength": 10,\
    "defence": 5,\
    "speed": 8,\
\}\
\
# --- State ---\
var status_effects: Array[StatusEffect] = []\
var is_alive: bool = true\
\
# --- Signals (local) ---\
signal stat_changed(stat: StringName, old_val: Variant, new_val: Variant)\
signal died()\
\
# ------------------------------------------------------------------ #\
\
func get_stat(key: StringName) -> Variant:\
    return stats.get(key, 0)\
\
func set_stat(key: StringName, value: Variant) -> void:\
    var old = stats.get(key)\
    stats[key] = value\
    stat_changed.emit(key, old, value)\
\
func modify_hp(delta: int) -> void:\
    var new_hp = clampi(get_stat("hp") + delta, 0, get_stat("max_hp"))\
    set_stat("hp", new_hp)\
    if delta < 0:\
        EventBus.actor_damaged.emit(self, -delta, null)\
    if new_hp <= 0:\
        _die()\
\
func _die() -> void:\
    if not is_alive:\
        return\
    is_alive = false\
    died.emit()\
    EventBus.actor_died.emit(self)\
\
# --- Override in subclasses ---\
func take_turn(combat: CombatSystem) -> void:\
    pass\
\
func choose_targets(combat: CombatSystem, ability: Ability) -> Array[Actor]:\
    return []}