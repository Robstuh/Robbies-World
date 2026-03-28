class_name Quest
extends Resource

@export var id: String = ""
@export var title: String = ""
@export var description: String = ""
@export var completed: bool = false
@export var objective_description: String = ""
@export var objective_required: int = 1
@export var objective_progress: int = 0

func progress(amount: int = 1) -> void:
    objective_progress = min(objective_progress + amount, objective_required)
    if objective_progress >= objective_required:
        completed = true

func reset() -> void:
    completed = false
    objective_progress = 0
