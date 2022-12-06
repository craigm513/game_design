extends Node2D

onready var audioStream = get_node("Audio/SoundEffect/AudioStreamPlayer");
var LevelCompletedSoundEffect = "res://Audio/Sound Effects/Level2CompletedSoundEffect.mp3";

func _ready():
	audioStream.stream = load(LevelCompletedSoundEffect);
	audioStream.play();

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Credits/GodotCredits.tscn")
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://Credits/GodotCredits.tscn")
