//
//  SceneKitView.swift
//  SceneKit Exploration
//
//  Created by Kaushik Manian on 24/4/25.
//

import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable {
    @Binding var action: SceneAction

    enum SceneAction {
        case none, jump, spin, funMode
    }

    class Coordinator: NSObject, SCNSceneRendererDelegate {
        var cubeNode: SCNNode?
        var cameraNode: SCNNode?
        var scene: SCNScene?
        var currentAction: SceneAction = .none
        var lastDropTime: TimeInterval = 0

        func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
            guard let cube = cubeNode, let camera = cameraNode else { return }

            // Update camera to follow cube
            let cubePos = cube.presentation.position
            camera.position = SCNVector3(cubePos.x, cubePos.y + 5, cubePos.z + 10)

            switch currentAction {
            case .jump:
                cube.physicsBody?.applyForce(SCNVector3(0, 10, 0), asImpulse: true)
            case .spin:
                cube.physicsBody?.applyTorque(SCNVector4(0, 1, 0, 5), asImpulse: true)
            case .funMode:
                if time - lastDropTime > 1 {
                    dropRandomShape(above: cubePos)
                    lastDropTime = time
                }
            default:
                break
            }
        }

        private func dropRandomShape(above position: SCNVector3) {
            guard let scene = scene else { return }

            let shapes: [SCNGeometry] = [
                SCNSphere(radius: 0.4),
                SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0.1),
                SCNPyramid(width: 0.6, height: 0.7, length: 0.6),
                SCNCone(topRadius: 0, bottomRadius: 0.4, height: 0.6)
            ]

            let geometry = shapes.randomElement()!
            geometry.firstMaterial?.diffuse.contents = UIColor(
                red: CGFloat.random(in: 0.3...1),
                green: CGFloat.random(in: 0.3...1),
                blue: CGFloat.random(in: 0.3...1),
                alpha: 1.0
            )

            let node = SCNNode(geometry: geometry)
            node.position = SCNVector3(position.x + Float.random(in: -2...2),
                                       position.y + 5,
                                       position.z + Float.random(in: -2...2))
            node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
            scene.rootNode.addChildNode(node)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        let scene = SCNScene()
        context.coordinator.scene = scene

        sceneView.scene = scene
        sceneView.backgroundColor = .black
        sceneView.delegate = context.coordinator
        sceneView.allowsCameraControl = true

        // Camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        context.coordinator.cameraNode = cameraNode

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

        // Cube (player-controlled)
        let cube = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
        let cubeNode = SCNNode(geometry: cube)
        cubeNode.position = SCNVector3(0, 5, 0)
        cubeNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        cubeNode.physicsBody?.mass = 1
        cubeNode.physicsBody?.restitution = 0.5
        scene.rootNode.addChildNode(cubeNode)
        context.coordinator.cubeNode = cubeNode

        // Camera constraint to follow cube
        let constraint = SCNLookAtConstraint(target: cubeNode)
        constraint.isGimbalLockEnabled = true
        cameraNode.constraints = [constraint]

        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        context.coordinator.currentAction = action
    }
}
