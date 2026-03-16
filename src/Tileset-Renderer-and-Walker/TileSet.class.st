"
Loads the PNG spritesheet and slices it into individual tiles. Each tile is given by a grid coordinate (col@row) and returned as a Form.
"
Class {
	#name : 'TileSet',
	#superclass : 'Object',
	#instVars : [
		'sheet',
		'tileSize'
	],
	#category : 'Tileset-Renderer-and-Walker',
	#package : 'Tileset-Renderer-and-Walker'
}

{ #category : 'as yet unclassified' }
TileSet class >> loadFrom: aFilePath tileSize: anInteger [
    ^ self new
        initializeFrom: aFilePath
        tileSize: anInteger

"Loads a Tileset as a PNG file. Tilesize gives the size of each tile. For my own sprites it is 32x32"
]

{ #category : 'initialization' }
TileSet >> initializeFrom: aFilePath tileSize: anInteger [
    sheet := ImageReadWriter formFromFileNamed: aFilePath.
    tileSize := anInteger.

"Loads the PNG using the file path"
]

{ #category : 'accessing' }
TileSet >> tileAt: aPoint [
    | origin |
    origin := (aPoint x * tileSize) @ (aPoint y * tileSize).
    ^ sheet copy: (origin extent: tileSize @ tileSize).

"Gives a single tile form the spritesheet corresponding to the coordinate of the tile. eg: 2@1 means column 2, row 1"
]
