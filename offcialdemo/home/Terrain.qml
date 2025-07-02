// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

/*
 * Terrain is on the background of the HomeView. It smoothly scrolls from right
 * to left.
 */

import QtQuick
import QtQuick3D

Node {
    id: terrainRoot

    property real b: 0
    property real m: 0
    property real d: 0
    property alias linesPos: terrainmaterial.linesPos

    Model {
        id: terrain

        scale.x: 100
        scale.y: 100
        scale.z: 100
        source: "plane.mesh"
        materials: terrainmaterial

        CustomMaterial {
            id: terrainmaterial

            property real move: m
            property real dayt: d
            property real linesPos: 0
            property TextureInput desertTexture
            property TextureInput desertTextureDay

            depthDrawMode: Material.AlwaysDepthDraw
            cullMode: Material.BackFaceCulling
            alwaysDirty: false
            destinationBlend: CustomMaterial.OneMinusSrcAlpha
            sourceBlend: CustomMaterial.SrcAlpha
            vertexShader: "desert.vert"
            fragmentShader: "desert.frag"

            desertTexture: TextureInput {

                texture: Texture {
                    source: "../images/terrainlines.png"
                }
            }

            desertTextureDay: TextureInput {

                texture: Texture {
                    source: "../images/terrainlineslight.png"
                }
            }
        }
    }
}
