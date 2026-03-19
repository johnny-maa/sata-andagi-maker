extends Control

var andagi_count: float = 0.0
var paranku_count: int = 0
var paranku_cost: int = 15
var obaa_count: int = 0
var obaa_cost: int = 100
var nabi_count: int = 0
var nabi_cost: int = 1000
var shop_count: int = 0
var shop_cost: int = 12000
var mall_count: int = 0
var mall_cost: int = 150000
var gusuku_count: int = 0
var gusuku_cost: int = 2000000
var fujinkai_count: int = 0
var fujinkai_cost: int = 33000000

var is_fever_mode: bool = false

@onready var count_label: Label = $CountLabel
var floating_text_scene = preload("res://FloatingText.tscn")

@onready var paranku_count_label: Label = $ShopScroll/ShopContainer/ParankuBox/ParankuCountLabel
@onready var paranku_cost_label: Label = $ShopScroll/ShopContainer/ParankuBox/ParankuCostLabel
@onready var hire_paranku_button: Button = $ShopScroll/ShopContainer/ParankuBox/HireParankuButton

@onready var obaa_count_label: Label = $ShopScroll/ShopContainer/ObaaBox/ObaaCountLabel
@onready var obaa_cost_label: Label = $ShopScroll/ShopContainer/ObaaBox/ObaaCostLabel
@onready var hire_obaa_button: Button = $ShopScroll/ShopContainer/ObaaBox/HireObaaButton

@onready var nabi_count_label: Label = $ShopScroll/ShopContainer/NabiBox/NabiCountLabel
@onready var nabi_cost_label: Label = $ShopScroll/ShopContainer/NabiBox/NabiCostLabel
@onready var add_nabi_button: Button = $ShopScroll/ShopContainer/NabiBox/AddNabiButton

@onready var shop_count_label: Label = $ShopScroll/ShopContainer/ShopBox/ShopCountLabel
@onready var shop_cost_label: Label = $ShopScroll/ShopContainer/ShopBox/ShopCostLabel
@onready var add_shop_button: Button = $ShopScroll/ShopContainer/ShopBox/AddShopButton

@onready var mall_count_label: Label = $ShopScroll/ShopContainer/MallBox/MallCountLabel
@onready var mall_cost_label: Label = $ShopScroll/ShopContainer/MallBox/MallCostLabel
@onready var build_mall_button: Button = $ShopScroll/ShopContainer/MallBox/BuildMallButton

@onready var gusuku_count_label: Label = $ShopScroll/ShopContainer/GusukuBox/GusukuCountLabel
@onready var gusuku_cost_label: Label = $ShopScroll/ShopContainer/GusukuBox/GusukuCostLabel
@onready var build_gusuku_button: Button = $ShopScroll/ShopContainer/GusukuBox/BuildGusukuButton

@onready var fujinkai_count_label: Label = $ShopScroll/ShopContainer/FujinkaiBox/FujinkaiCountLabel
@onready var fujinkai_cost_label: Label = $ShopScroll/ShopContainer/FujinkaiBox/FujinkaiCostLabel
@onready var add_fujinkai_button: Button = $ShopScroll/ShopContainer/FujinkaiBox/AddFujinkaiButton

func _ready() -> void:
	load_game()
	$AutoTimer.wait_time = 0.1 # More responsive UI updates
	setup_golden_andagi_timer()
	update_ui()

func _process(delta: float) -> void:
	var multiplier = 7.0 if is_fever_mode else 1.0
	var base_prod = (paranku_count * 0.1) + (obaa_count * 1.0)
	base_prod += (nabi_count * 8.0) + (shop_count * 47.0) + (mall_count * 260.0)
	base_prod += (gusuku_count * 1400.0) + (fujinkai_count * 7800.0)
	var production_per_sec = base_prod * multiplier
	andagi_count += production_per_sec * delta

func _on_andagi_button_pressed() -> void:
	var multiplier = 7.0 if is_fever_mode else 1.0
	andagi_count += 1.0 * multiplier
	var tween = create_tween()
	$AndagiButton.scale = Vector2(0.9, 0.9)
	tween.tween_property($AndagiButton, "scale", Vector2(1.0, 1.0), 0.1)
	
	var ft = floating_text_scene.instantiate()
	ft.get_node("Label").text = "+" + str(1.0 * multiplier)
	ft.global_position = get_global_mouse_position()
	add_child(ft)
	
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

func buy_nabi() -> void:
	if andagi_count >= nabi_cost:
		andagi_count -= nabi_cost
		nabi_count += 1
		nabi_cost = int(round(nabi_cost * 1.15))
		update_ui()

func buy_shop() -> void:
	if andagi_count >= shop_cost:
		andagi_count -= shop_cost
		shop_count += 1
		shop_cost = int(round(shop_cost * 1.15))
		update_ui()

func buy_mall() -> void:
	if andagi_count >= mall_cost:
		andagi_count -= mall_cost
		mall_count += 1
		mall_cost = int(round(mall_cost * 1.15))
		update_ui()

func buy_gusuku() -> void:
	if andagi_count >= gusuku_cost:
		andagi_count -= gusuku_cost
		gusuku_count += 1
		gusuku_cost = int(round(gusuku_cost * 1.15))
		update_ui()

func buy_fujinkai() -> void:
	if andagi_count >= fujinkai_cost:
		andagi_count -= fujinkai_cost
		fujinkai_count += 1
		fujinkai_cost = int(round(fujinkai_cost * 1.15))
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
	
	nabi_count_label.text = "所持数: " + str(nabi_count) + " 個"
	nabi_cost_label.text = "コスト: " + str(nabi_cost)
	add_nabi_button.disabled = andagi_count < nabi_cost
	
	shop_count_label.text = "所持数: " + str(shop_count) + " 軒"
	shop_cost_label.text = "コスト: " + str(shop_cost)
	add_shop_button.disabled = andagi_count < shop_cost
	
	mall_count_label.text = "所持数: " + str(mall_count) + " 軒"
	mall_cost_label.text = "コスト: " + str(mall_cost)
	build_mall_button.disabled = andagi_count < mall_cost
	
	gusuku_count_label.text = "所持数: " + str(gusuku_count) + " 城"
	gusuku_cost_label.text = "コスト: " + str(gusuku_cost)
	build_gusuku_button.disabled = andagi_count < gusuku_cost
	
	fujinkai_count_label.text = "所持数: " + str(fujinkai_count) + " 人"
	fujinkai_cost_label.text = "コスト: " + str(fujinkai_cost)
	add_fujinkai_button.disabled = andagi_count < fujinkai_cost

const SAVE_PATH = "user://save_data.json"

func save_game() -> void:
	var save_dict = {
		"andagi_count": andagi_count,
		"paranku_count": paranku_count,
		"paranku_cost": paranku_cost,
		"obaa_count": obaa_count,
		"obaa_cost": obaa_cost,
		"nabi_count": nabi_count,
		"nabi_cost": nabi_cost,
		"shop_count": shop_count,
		"shop_cost": shop_cost,
		"mall_count": mall_count,
		"mall_cost": mall_cost,
		"gusuku_count": gusuku_count,
		"gusuku_cost": gusuku_cost,
		"fujinkai_count": fujinkai_count,
		"fujinkai_cost": fujinkai_cost
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_dict))
		file.close()
		show_save_notification()

func load_game() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			var content = file.get_as_text()
			file.close()
			var json = JSON.new()
			var error = json.parse(content)
			if error == OK:
				var data = json.get_data()
				if data is Dictionary:
					andagi_count = data.get("andagi_count", 0.0)
					if str(andagi_count).is_valid_float():
						andagi_count = float(andagi_count)
					paranku_count = int(data.get("paranku_count", 0))
					paranku_cost = int(data.get("paranku_cost", 15))
					obaa_count = int(data.get("obaa_count", 0))
					obaa_cost = int(data.get("obaa_cost", 100))
					nabi_count = int(data.get("nabi_count", 0))
					nabi_cost = int(data.get("nabi_cost", 1000))
					shop_count = int(data.get("shop_count", 0))
					shop_cost = int(data.get("shop_cost", 12000))
					mall_count = int(data.get("mall_count", 0))
					mall_cost = int(data.get("mall_cost", 150000))
					gusuku_count = int(data.get("gusuku_count", 0))
					gusuku_cost = int(data.get("gusuku_cost", 2000000))
					fujinkai_count = int(data.get("fujinkai_count", 0))
					fujinkai_cost = int(data.get("fujinkai_cost", 33000000))

func show_save_notification() -> void:
	var save_label = $SaveLabel
	save_label.visible = true
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(func(): save_label.visible = false)

func _on_save_button_pressed() -> void:
	save_game()

func setup_golden_andagi_timer() -> void:
	var spawn_timer = Timer.new()
	spawn_timer.wait_time = randf_range(180.0, 300.0)
	spawn_timer.one_shot = true
	spawn_timer.timeout.connect(_on_golden_andagi_spawn_timer_timeout.bind(spawn_timer))
	add_child(spawn_timer)
	spawn_timer.start()

func _on_golden_andagi_spawn_timer_timeout(timer: Timer) -> void:
	spawn_golden_andagi()
	timer.wait_time = randf_range(180.0, 300.0)
	timer.start()

func spawn_golden_andagi() -> void:
	var btn = TextureButton.new()
	btn.texture_normal = preload("res://icon.svg")
	btn.modulate = Color(1, 0.84, 0) # Gold color
	btn.ignore_texture_size = true
	btn.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	btn.custom_minimum_size = Vector2(64, 64)
	btn.size = Vector2(64, 64)
	
	var vp_size = get_viewport_rect().size
	btn.position = Vector2(
		randf_range(0, max(0, vp_size.x - 64)),
		randf_range(0, max(0, vp_size.y - 64))
	)
	
	btn.pressed.connect(_on_golden_andagi_pressed.bind(btn))
	add_child(btn)
	
	var timer = get_tree().create_timer(10.0)
	timer.timeout.connect(func():
		if is_instance_valid(btn):
			btn.queue_free()
	)

func _on_golden_andagi_pressed(btn: TextureButton) -> void:
	if is_instance_valid(btn):
		btn.queue_free()
	start_fever_mode()

func start_fever_mode() -> void:
	is_fever_mode = true
	count_label.modulate = Color(1, 0.84, 0)
	
	var timer = get_tree().create_timer(30.0)
	timer.timeout.connect(func():
		is_fever_mode = false
		count_label.modulate = Color(1, 1, 1)
	)
