class_name SingleState

const NO_ACTION_NAME = ""
static var NO_ACTION = DualInputAction.new()
var state = NO_ACTION
var spec : Dictionary

func _init(spec: Dictionary) -> void:
	self.spec = spec

func ifSpecAction(event: InputEvent) -> String:
	for action in spec.keys():
		var isAction = event.is_action(action, true)
		if isAction: return action
	return NO_ACTION_NAME

func merge(event: InputEvent) -> void:
	var action = ifSpecAction(event)
	if NO_ACTION_NAME == action: return
	var effectiveSpec = spec[action]
	# push down event, spec[name] here maybe 
	var nextstate = Events.on(event, effectiveSpec, NO_ACTION)
	if NO_ACTION == nextstate: return 
	state = join(effectiveSpec,nextstate, state)

static func join(spec: Events.ActionSpec, next: DualInputAction, state: DualInputAction) -> DualInputAction:
	if NO_ACTION == state:
		return next
	
	if state.pressed == true && next.pressed == true:
		next.level += state.level
		return next
		
	if state.pressed == true && next.pressed == false:
		## for short actions
		if is_equal_approx(spec.onFirstActivation(),state.level):
			next.level = spec.onMaxActivation()
		else:
			next.level += state.level
		return next
		
	return NO_ACTION
