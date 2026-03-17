| ts tm walker tileSize mapW mapH mapForm scaledForm morph scale |

tileSize := 32.  "Due to the 32x32 pixel art in the spritesheet, you can change                    it if you have a different spritesheet"
mapW := 8.		  "Choose map width as number of tiles "
mapH := 8.		  "Choose map height as number of tiles "
scale := 2.5.      "Choose the scaling, as at low scales, the output can be small"

ts := TileSet loadFrom: 'C:/Users/Arush/Downloads/Aseprite Sprites/GSoC-Sprites.png' tileSize: tileSize. "Give the path of the spritesheet"

tm := TileMap new
    initializeWidth: mapW
    height: mapH
    tileSet: ts
    tileSize: tileSize.

tm at: 1@1 put: 1@0. "Choose at which tiles on the map you want special tiles :)"
tm at: 4@4 put: 0@1.    
tm at: 2@3 put: 2@0. "The spritesheet I made is a garden biome with flowers, "
tm at: 4@2 put: 1@1. " grasses, rocks and puddles. You can choose any."
tm at: 5@5 put: 2@1.
tm at: 7@6 put: 0@2.
tm at: 7@0 put: 1@2.
tm at: 2@4 put: 2@2.
tm at: 5@3 put: 1@0.
tm at: 3@2 put: 0@1.    
tm at: 4@5 put: 2@0.
tm at: 5@7 put: 1@1.
tm at: 7@2 put: 2@1.
tm at: 6@3 put: 0@2.
tm at: 2@6 put: 1@2.
tm at: 1@7 put: 2@2.

walker := Walker new
    initializeAt: 5@3
    mapWidth: mapW
    mapHeight: mapH.

walker loadSpriteFrom: 'C:\Users\Arush\Downloads\Aseprite Sprites\GSoC-Agent.png'.  "Gives path of the walker"

mapForm := Form extent: (mapW * tileSize) @ (mapH * tileSize) depth: 32.
tm renderOn: mapForm.
scaledForm := mapForm magnifyBy: scale.

morph := ImageMorph new image: scaledForm.
morph openInWorld.
morph position: 50@50.

[
    1 to: 30 do: [ :i |   "The walker moves 30 times"
        walker step.
        mapForm := Form extent: (mapW * tileSize) @ (mapH * tileSize) depth: 32.
        tm renderOn: mapForm.
        walker renderOn: mapForm tileSize: tileSize.
        scaledForm := mapForm magnifyBy: scale.
        morph image: scaledForm.
        morph changed.
        (Delay forMilliseconds: 500) wait. "Each step takes 500 ms"
    ].
] forkAt: Processor userBackgroundPriority.
