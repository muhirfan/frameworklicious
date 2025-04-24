//
//  SceneKitView.swift
//  SceneKit Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import Foundation
import SwiftUI
import SceneKit

class SceneKitController: ObservableObject {
    fileprivate var cubeNode: SCNNode?
    fileprivate var scene: SCNScene?

    func jump() {
        cubeNode?.physicsBody?.applyForce(SCNVector3(0, 10, 0), asImpulse: true)
    }

    func spin() {
        cubeNode?.physicsBody?.applyTorque(SCNVector4(0, 1, 0, 5), asImpulse: true)
    }

    func toggleGravity() {
        guard let scene = scene else { return }
        let gravity = scene.physicsWorld.gravity
        if gravity.x == 0 && gravity.y == -9.8 && gravity.z == 0 {
            scene.physicsWorld.gravity = SCNVector3Zero
        } else {
            scene.physicsWorld.gravity = SCNVector3(0, -9.8, 0)
        }
    }
}

struct SceneKitView: UIViewRepresentable {
    var controller: SceneKitController

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = .black

        // Save scene reference
        controller.scene = scene

        // Camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 5, 15)
        scene.rootNode.addChildNode(cameraNode)

        // Lights
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(0, 10, 10)
        scene.rootNode.addChildNode(lightNode)

        let ambient = SCNNode()
        ambient.light = SCNLight()
        ambient.light?.type = .ambient
        ambient.light?.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambient)

        // Floor
        let floorNode = SCNNode(geometry: SCNFloor())
        floorNode.physicsBody = SCNPhysicsBody.static()
        scene.rootNode.addChildNode(floorNode)

        // Cube
        let cube = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = SCNVector3(0, 5, 0)
        cubeNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        cubeNode.physicsBody?.mass = 1
        cubeNode.physicsBody?.restitution = 0.5

        scene.rootNode.addChildNode(cubeNode)

        // Save reference for controller
        controller.cubeNode = cubeNode

        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {}
}
