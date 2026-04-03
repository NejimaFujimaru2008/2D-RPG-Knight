extends TextureRect

@onready var counter: Label = $CoinCounter

func _ready():
	# Connect to GameManager's signal
	GameManager.score_changed.connect(_on_score_changed)
	# Initialize the label with current score
	counter.text = str(GameManager.score)

func _on_score_changed(new_score):
	counter.text = str(new_score)
