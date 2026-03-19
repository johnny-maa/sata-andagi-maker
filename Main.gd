extends Control

var andagi_count: float = 0.0
var paranku_count: int = 0
var paranku_cost: int = 15
var obaa_count: int = 0
var obaa_cost: int = 100

@onready var count_label: Label = $CountLabel

@onready var paranku_count_label: Label = $ShopContainer/ParankuBox/ParankuCountLabel
@onready var paranku_cost_label: Label = $ShopContainer/ParankuBox/ParankuCostLabel
@onready var hire_paranku_button: Button = $ShopContainer/ParankuBox/HireParankuButton

@onready var obaa_count_label: Label = $ShopContainer/ObaaBox/ObaaCountLabel
@onready var obaa_cost_label: Label = $ShopContainer/ObaaBox/ObaaCostLabel
@onready var hire_obaa_button: Button = $ShopContainer/ObaaBox/HireObaaButton

func _ready() -> void:
	$AutoTimer.wait_time = 0.1 # More responsive UI updates
	update_ui()

func _process(delta: float) -> void:
	var production_per_sec = (paranku_count * 0.1) + (obaa_count * 1.0)
	andagi_count += production_per_sec * delta

func _on_andagi_button_pressed() -> void:
	andagi_count += 1.0
	var tween = create_tween()
	$AndagiButton.scale = Vector2(0.9, 0.9)
	tween.tween_property($AndagiButton, "scale", Vector2(1.0, 1.0), 0.1)
	update_ui()

func buy_paranku() -> void:
	if andagi_count >= paranku_cost:
		andagi_count -= paranku_cost
		paranku_count += 1
		paranku_cost = int(round(paranku_cost * 1.15))
		update_ui()

func buy_obaa() -> void:
	if andagi_count >= obaa_cost:
		andagi_count -= obaa_cost
		obaa_count += 1
		obaa_cost = int(round(obaa_cost * 1.15))
		update_ui()

func _on_auto_timer_timeout() -> void:
	update_ui()

func update_ui() -> void:
	count_label.text = "アンダギー: " + str(int(andagi_count))
	
	paranku_count_label.text = "所持数: " + str(paranku_count) + " 個"
	paranku_cost_label.text = "コスト: " + str(paranku_cost)
	hire_paranku_button.disabled = andagi_count < paranku_cost
	
	obaa_count_label.text = "所持数: " + str(obaa_count) + " 人"
	obaa_cost_label.text = "コスト: " + str(obaa_cost)
	hire_obaa_button.disabled = andagi_count < obaa_cost
