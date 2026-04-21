class_name Player
extends Actor

@export var move_speed: float = 180.0

func _ready() -> void:
    GameState.current_player = self
    connect("leveled_up", Callable(self, "_on_leveled_up"))

func _on_leveled_up(new_level):
    print("Leveled up to level ", new_level, "!")

func _physics_process(delta: float) -> void:
    var input_vec = Vector2.ZERO
    input_vec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    input_vec.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
    input_vec = input_vec.normalized()
    velocity = input_vec * move_speed
    move_and_slide()

func _on_body_entered(body: Node) -> void:
    if body is Actor and body != self:
        EventBus.request_enter_combat.emit([body])
