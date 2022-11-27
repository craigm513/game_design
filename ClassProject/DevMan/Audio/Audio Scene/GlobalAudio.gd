extends AudioStreamPlayer

var GraveyardAudio = "res://Audio/Music/GraveyardSoundtrack.wav";
var GlobalAudio = "res://Audio/Music/PROD_BY_YOGIC_BEATS.mp3";

var audioStatus = "NULL";

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	print(get_tree().current_scene.name);
	if get_tree().current_scene.name == "GraveYard" && audioStatus != "GraveYard":
		self.stream = load(GraveyardAudio)
		audioStatus = "GraveYard";
		self.play();
	
	if get_tree().current_scene.name == "Options" and audioStatus != "Global":
		self.stream = load(GlobalAudio)
		audioStatus = "Global"
		self.play();

	if get_tree().current_scene.name == "MainMenu" and audioStatus != "Global":
		self.stream = load(GlobalAudio)
		audioStatus = "Global"
		self.play();
		
	if get_tree().current_scene.name == "Credits" and audioStatus != "Global":
		self.stream = load(GlobalAudio)
		audioStatus = "Global"
		self.play();
		
	if get_tree().current_scene.name == "LevelSelect" and audioStatus != "Global":
		self.stream = load(GlobalAudio)
		audioStatus = "Global"
		self.play();			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
