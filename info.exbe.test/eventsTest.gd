extends GutTest

var params_spec = ParameterFactory.named_parameters(
	['events', 'expected','name'], # names
	[   # values
		specSinglePositiveKeyPress(),
		specSingleInverseKeyPress(),
		specHoldPositiveKey(),
		specHoldInverseKey()
	])

func test_events(params = use_parameters(params_spec)):
	var controller = SingleState.new(MyTestActions.combinerSpec())
	for e in params.events:
		# iteration here could be used as a replacement of _physics_process
		controller.merge(e)
	assert_not_null(controller.state)	
	assert_eq(controller.state.action, params.expected.action, msg(params.name, "Action should be same"))
	assert_almost_eq(controller.state.level,params.expected.level,.05,msg(params.name, "out of range " + str(controller.state.strength)))


static func msg(specName:String, message: String) -> String:
	return specName + ": " + message
	
static func singleKeyPressForAction(action: String, key: Key) -> Array[InputEventKey]:
	var events = KeyEventGenerator.oneKeyPress(key)
	KeyEventGenerator.of(action, events)
	return events
	
static func holdKeyPressForAction(action: String, key: Key) -> Array[InputEventKey]:
	var events = KeyEventGenerator.oneKeyHoldPress(key)
	KeyEventGenerator.of(action, events)
	return events

static func specSinglePositiveKeyPress() -> Array:
	var event = DualInputAction.new()
	event.action = MyTestActions.MY_TEST_ACTION_DELTA
	event.level = 0.8
	return [singleKeyPressForAction(MyTestActions.MY_TEST_ACTION_LEFT, KEY_LEFT),event,"singlePositiveKey"]
	
static func specSingleInverseKeyPress() -> Array:
	var event = DualInputAction.new()
	event.action = MyTestActions.MY_TEST_ACTION_DELTA
	event.level = -0.8
	return [singleKeyPressForAction(MyTestActions.MY_TEST_ACTION_RIGHT, KEY_RIGHT),event,"singleInverseKey"]

static func specHoldPositiveKey() -> Array:
	var event = DualInputAction.new()
	event.action = MyTestActions.MY_TEST_ACTION_DELTA
	event.level = 2.18
	return [holdKeyPressForAction(MyTestActions.MY_TEST_ACTION_LEFT, KEY_LEFT),event,"holdPositiveKey"]

static func specHoldInverseKey() -> Array:
	var event = DualInputAction.new()
	event.action = MyTestActions.MY_TEST_ACTION_DELTA
	event.level = -2.18
	return [holdKeyPressForAction(MyTestActions.MY_TEST_ACTION_RIGHT, KEY_RIGHT),event,"holdInverseKey"]
