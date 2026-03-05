extends Control

var textbox_scene = Global.get_scene(Global.SceneKey.TEXT_BOX)

var cutscene_data: Dictionary = {}
var current_index = 0
var active_nodes = {}

signal tapped
signal done(level_num)
signal quit_game

func _ready():
	$InputCatcher.gui_input.connect(_on_gui_input)

func play(file_path):
	cutscene_data = _read_data(file_path)
	current_index = 0
	_advance()
	
func _advance():
	if current_index >= cutscene_data["timeline"].size():
		return
	
	var event = cutscene_data["timeline"][current_index]
	current_index += 1
	await _render(event)
	_advance()
	
func _render(event):
	match event.get("type"):
		"music":
			$OST/CutsceneOST.stream = load(event["src"])
			$OST/CutsceneOST.play()
		"background":
			await _render_background(event)
		"animate":
			await _render_animation(event)
		"text":
			await _render_text(event)
		"text_box":
			await _render_text_box(event)
		"scene_strip":
			await  _render_scene_strip(event)
		"choice":
			await _render_choice(event)
		"wait":
			await _wait(event)
		"wait_tap":
			await _wait_tap()
		"wait_choice":
			_wait_choice(event)
		"end":
			done.emit()
		_:
			print("Unknown event type")

func _render_background(event):
	var background = TextureRect.new()
	background.texture = load(event["src"])
	background.modulate.a = 0.0
	
	# Fill entire screen
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	background.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	background.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	# Optional: control how texture scales
	background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	# Other options:
	# STRETCH_SCALE
	# STRETCH_KEEP_ASPECT
	# STRETCH_KEEP_ASPECT_CENTERED
	$Background.add_child(background)
	active_nodes[event["id"]] = background
	
func _render_animation(event):
	var target_node = active_nodes[event["target"]]
	var animation_type = event["animation"]["type"]
	var animation_duration = event["animation"]["duration"]
	var tween = create_tween()
		
	match animation_type:
		"fade_in":
			tween.tween_property(target_node, "modulate:a", 1.0, animation_duration)
		"fade_out":
			tween.tween_property(target_node, "modulate:a", 0.0, animation_duration)
		_:
			print("Unknow animation")

func _wait(event):
	await get_tree().create_timer(event["duration"]).timeout

func _wait_tap():
	await tapped

func _wait_choice(event):
	pass

func _render_text(event):
	var text_label = Label.new()
	text_label.text = event["content"]
	text_label.add_theme_font_size_override("font_size", 100)
	text_label.modulate.a = 0.0
	
	text_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	text_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	text_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	
	$Text.add_child(text_label)
	
	active_nodes[event["id"]] = text_label
	
func _render_text_box(event):
	if event["id"] not in active_nodes:
		var text_box = textbox_scene.instantiate()
		text_box.render_portrait(event["portrait_src"])
		text_box.display_text(event["name"], event["content"])
		$TextBox.add_child(text_box)
		active_nodes[event["id"]] = text_box
	else:
		var text_box = active_nodes[event["id"]]
		text_box.display_text(event["name"], event["content"])

func _render_scene_strip(event):
	pass
	
func _render_choice(event):
	pass

func _read_data(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		push_error("could not find the file " + file_path)
		return
	
	var json_text = file.get_as_text()
	file.close()
	
	var parsed = JSON.parse_string(json_text)
	
	if parsed == null:
		push_error("Invalid JSON in " + file_path)
		return
		
	return parsed
	
func _on_gui_input(event):
	if event is InputEventScreenTouch and event.pressed:
		tapped.emit()
	elif event is InputEventMouseButton and event.pressed:
		tapped.emit()
