{\rtf1\ansi\ansicpg1252\cocoartf2867
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 extends Node\
\
enum Mode \{ EXPLORATION, COMBAT, DIALOGUE, CUTSCENE, PAUSED, MENU \}\
\
var current_mode: Mode = Mode.EXPLORATION\
var player: Player\
var active_combat: CombatSystem\
\
func transition(new_mode: Mode) -> void:\
    if new_mode == current_mode:\
        return\
    _on_exit(current_mode)\
    current_mode = new_mode\
    _on_enter(new_mode)\
\
func _on_exit(mode: Mode) -> void:\
    match mode:\
        Mode.COMBAT:\
            if active_combat:\
                active_combat.teardown()\
                active_combat = null\
\
func _on_enter(mode: Mode) -> void:\
    match mode:\
        Mode.COMBAT:\
            pass  # CombatSystem initialises itself via EventBus\
        Mode.PAUSED:\
            get_tree().paused = true\
        _:\
            get_tree().paused = false}