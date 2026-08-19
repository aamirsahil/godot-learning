class_name StateMachine
extends Node

@export var starting_state: State

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	var owner_enemy := get_owner() as Enemy
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.enemy = owner_enemy
	if starting_state:
		current_state = starting_state
		current_state.enter()

func _physics_process(delta: float) -> void:
	if not current_state:
		return
	current_state.physics_update(delta)
	var next_state_name := current_state.get_transition()
	if next_state_name != "" and states.has(next_state_name):
		transition_to(next_state_name)

func transition_to(state_name: String) -> void:
	current_state.exit()
	current_state = states[state_name]
	current_state.enter()
