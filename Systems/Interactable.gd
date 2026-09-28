class_name Interactable
extends Area3D

signal interacted(interactor: Node)
signal focused
signal unfocused

@export var prompt_text := "Interact"

func interact(interactor: Node) -> void:
	interacted.emit(interactor)

func focus() -> void:
	focused.emit()

func unfocus() -> void:
	unfocused.emit()

func change_prompt_text(prompt: String) -> void:
	prompt_text = prompt
