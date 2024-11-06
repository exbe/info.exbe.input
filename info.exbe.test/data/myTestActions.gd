class_name MyTestActions

const MY_TEST_ACTION_LEFT = "my-action-left"
const MY_TEST_ACTION_RIGHT = "my-action-right"
const MY_TEST_ACTION_DELTA = "my-action-delta"

static func combinerSpec() -> Dictionary:
	var spec = Events.combiner(MY_TEST_ACTION_LEFT, MY_TEST_ACTION_RIGHT, MY_TEST_ACTION_DELTA)
	return spec
	
