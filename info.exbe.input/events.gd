class_name Events

static func on(event: InputEvent, spec: ActionSpec, fallback: DualInputAction) -> DualInputAction:
	# New action 
	if event.is_action_pressed(spec.name) && !event.is_echo() && !event.is_action_released(spec.name):
		var state = DualInputAction.new()
		state.action = spec.toAction
		state.pressed = true
		state.level = spec.onFirstActivation() 
		return state
		
	# Continuous action
	if event.is_action(spec.name) && event.is_echo():
		var state = DualInputAction.new()
		state.action = spec.toAction
		state.pressed = true
		state.level = spec.onContinuousActivation() 
		return state
		
	# Completed action
	if !event.is_action_pressed(spec.name) && !event.is_echo() && event.is_action_released(spec.name):
		var state = DualInputAction.new()
		state.action = spec.toAction
		state.level = spec.onCompleteActivation() 
		state.pressed = false
		return state

		
	return fallback
		
static func combiner(action: String, inverseAction: String, asAction: String) -> Dictionary:
	var actionSpec = ActionSpec.new(action)
	var inverseActionSpec = ActionSpec.new(inverseAction, true)
	var spec = {
		action:actionSpec,
		inverseAction:inverseActionSpec
	}
	
	actionSpec.inverse = inverseActionSpec
	actionSpec.toAction = asAction
	
	
	inverseActionSpec.inverse = actionSpec
	inverseActionSpec.toAction = asAction
	
	
	return spec



class ActionSpec:
	var inverse : ActionSpec
	var name: String
	var toAction: String
	var isInverse: bool
	var firstActivationStrength: float = 0.65
	var completeActivationStrength: float = 0.53
	var continuousActivationStrength: float = 0.1
	var maxActivationStrength: float = 0.85

	
	func _init(name: String, inverse: bool = false) -> void:
		self.name = name
		self.isInverse = inverse
		
		if isInverse:
			firstActivationStrength      = -firstActivationStrength
			completeActivationStrength   = -completeActivationStrength
			maxActivationStrength        = -maxActivationStrength
			continuousActivationStrength = -continuousActivationStrength

	
	func onFirstActivation():
		return firstActivationStrength
		
	func onCompleteActivation():
		return completeActivationStrength
		
	func onMaxActivation():
		return maxActivationStrength		

	func onContinuousActivation():
		return continuousActivationStrength	
