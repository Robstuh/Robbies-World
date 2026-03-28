extends Node

signal request_enter_combat(enemy_list)
signal request_return_to_exploration()
signal request_dialogue(actor)
signal request_dialogue_advance()
signal actor_damaged(actor, damage, source)
signal actor_died(actor)
signal item_picked(item_id)
signal request_quest_progress(quest_id, amount)
