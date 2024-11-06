New component checklist:
 - [x] replace **name_it** in README
 - [x] two-sentence desription of the component purpose in the current state
 - [ ] update structured data, if applicable
 - [ ] update LICENSE, specifically **licence_year** and **auhtors**
 - [ ] assign repository `tags` in github, if applicable
 - [x] add code  
 - [ ] the checklist is removed before initial commit


:scissors: tear line below
----

# :microscope: Incubating: info.exbe.input
:sparkles: Handles input from keyboard and generates **DualInputAction** event for dowmstream controllers.

This layer is responsible ot accumulate and transform input action from various devidces into more generic actions to reduces the boilerplate.

#### Example
Left-right movent assigned to different buttons generates 2 events, but they are essentually single event, since above are inverse of each other.


#### Events
Current implementation (for the exploration) only handles keyboard events.
**ActionSpec** is responsible to declare events and their inverse conterparts.

#### DualInputAction
DualInputAction is an InputEventAction, which introduces unbound signed *level* property.
InputEventAction alredy provides streight but it requires curbersom compute to make it work for inverse events.
