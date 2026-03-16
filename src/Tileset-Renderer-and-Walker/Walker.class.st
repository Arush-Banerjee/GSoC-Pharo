"
Used to animate a wandering agent across the map in four directions: left, right, top and bottom, while also being constained to be inside the map. 
"
Class {
	#name : 'Walker',
	#superclass : 'Object',
	#instVars : [
		'position',
		'mapWidth',
		'mapHeight',
		'sprite'
	],
	#category : 'Tileset-Renderer-and-Walker',
	#package : 'Tileset-Renderer-and-Walker'
}

{ #category : 'accessing' }
Walker >> initializeAt: aPoint mapWidth: w mapHeight: h [
    position := aPoint.
    mapWidth := w.
    mapHeight := h.

"Gives the walker's starting position and the space he is constrained to move within"
]

{ #category : 'as yet unclassified' }
Walker >> loadSpriteFrom: aFilePath [
    sprite := ImageReadWriter formFromFileNamed: aFilePath.

"Loads the sprite of the walker"
]

{ #category : 'rendering' }
Walker >> renderOn: aForm tileSize: anInteger [
    | screenPos |
    screenPos := (position * anInteger).
    
    sprite displayOn: aForm
             at: screenPos
             clippingBox: (0@0 extent: aForm extent)
             rule: Form paint
             fillColor: nil.

"Draws the walker"
]

{ #category : 'stepping' }
Walker >> step [
    | directions chosen next |
    directions := { 0@ -1. 0@1. -1@0. 1@0 }.
    chosen := directions atRandom.
    next := (((position x + chosen x) max: 0) min: mapWidth - 1)
            @ (((position y + chosen y) max: 0) min: mapHeight - 1).
    position := next.

"Move in a random direction while also being inside the map"
]
