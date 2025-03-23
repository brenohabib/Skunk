extends Node

@onready var piano: AudioStreamPlayer = self.get_child(0)
@onready var bossa: AudioStreamPlayer = self.get_child(1)
@onready var rock: AudioStreamPlayer = self.get_child(2)

@export var transition_time: float = 1.5
@export var current_music: AudioStreamPlayer = null

func _ready() -> void:
    mute()

    piano.play()
    bossa.play()
    rock.play()

func transition_to(new_music: AudioStreamPlayer) -> void:
    var tween = create_tween()

    if current_music != null:
        tween.parallel().tween_property(current_music, "volume_db", -80.0, transition_time)

    tween.parallel().tween_property(new_music, "volume_db", 0.0, transition_time)

    current_music = new_music

func set_music_piano() -> void:
    transition_to(piano)

func set_music_bossa() -> void:
    transition_to(bossa)

func set_music_rock() -> void:
    transition_to(rock)

func mute() -> void:
    piano.volume_db = -80.0
    bossa.volume_db = -80.0
    rock.volume_db = -80.0