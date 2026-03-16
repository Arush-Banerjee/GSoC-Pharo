"
Represents a 2D grid of tile coordinates. It then renders the full grid by slicing each tile corresponding to their coords. in the spritesheet and rendering them at the correct position
"
Class {
	#name : 'TileMap',
	#superclass : 'Object',
	#instVars : [
		'tileSet',
		'grid',
		'mapWidth',
		'mapHeight',
		'tileSize'
	],
	#category : 'Tileset-Renderer-and-Walker',
	#package : 'Tileset-Renderer-and-Walker'
}

{ #category : 'accessing' }
TileMap >> at: aPoint [
    ^ (grid at: aPoint y + 1) at: aPoint x + 1

"Gives the tile coord from the spritesheet of a map position"
]

{ #category : 'accessing' }
TileMap >> at: aPoint put: aTileCoord [
    (grid at: aPoint y + 1) at: aPoint x + 1 put: aTileCoord.

"To put special tiles at positions on the map decided by the user"
]

{ #category : 'initialization' }
TileMap >> initializeWidth: w height: h tileSet: aTileSet tileSize: anInteger [
    mapWidth := w.
    mapHeight := h.
    tileSet := aTileSet.
    tileSize := anInteger.
    grid := (1 to: h) collect: [ :row |
        Array new: w withAll: 0@0
    ].

"Setup the map with given dimensions and the tileset spritesheet and tilesize. The grid is in default set to the grass tile"
]

{ #category : 'rendering' }
TileMap >> renderOn: aForm [
    0 to: mapHeight - 1 do: [ :row |
        0 to: mapWidth - 1 do: [ :col |
            | tileCoord tile screenPos |
            tileCoord := self at: col @ row.
            tile := tileSet tileAt: tileCoord.
            screenPos := (col * tileSize) @ (row * tileSize).
            tile displayOn: aForm
                 at: screenPos
                 clippingBox: (0@0 extent: (mapWidth * tileSize) @ (mapHeight * tileSize))
                 rule: Form over
                 fillColor: nil.
        ]
    ].

"Forms a full map by iteratting over every cell"
]
