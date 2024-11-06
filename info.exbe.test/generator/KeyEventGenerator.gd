class_name KeyEventGenerator


static func oneKeyPress(key : Key) -> Array[InputEventKey]:
	var press = GutUtils.InputFactory.key_down(key)
	var release = GutUtils.InputFactory.key_up(key)
	return [press, release]
	
static func oneKeyHoldPress(key: Key, repeat: int = 10) -> Array[InputEventKey]:
	var events:Array[InputEventKey] = []
	events.append(GutUtils.InputFactory.key_down(key))
	for x in range(repeat):
		var hold =GutUtils.InputFactory.key_down(key)
		hold.echo = true
		events.append(hold)

	events.append(GutUtils.InputFactory.key_up(key))
	return events
	

static func of(action:String, events: Array, deadzone: float = 0.5) -> void:
	InputMap.add_action(action, deadzone)
	for e in events:
		InputMap.action_add_event(action,e)

static func rollback(action:String) -> void:
		if InputMap.has_action(action):
			InputMap.erase_action(action)
			
