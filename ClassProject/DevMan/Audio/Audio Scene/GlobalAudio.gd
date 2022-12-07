extends AudioStreamPlayer

var GraveyardAudio = "res://Audio/Music/GraveyardSoundtrack.wav";
var GlobalAudio = "res://Audio/Music/GlobalSoundtrack.mp3";
var WithTimeAudio = "res://Audio/Music/WithTimeSoundtrack.wav";

var audioStatus = "NULL";

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(_delta):
	print(get_tree().current_scene.name);
	if get_tree().current_scene.name == "GraveYardLevel" && audioStatus != "GraveYardLevel":
		self.stream = load(GraveyardAudio)
		audioStatus = "GraveYardLevel";
		self.play();
		
	if get_tree().current_scene.name == "withTimeLevel" and audioStatus != "WithTime":
		self.stream = load(WithTimeAudio)
		audioStatus = "WithTime"
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
