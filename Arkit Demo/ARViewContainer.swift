//
//  ARViewContainer.swift
//  Arkit Demo
//
//  Created by Kaushik Manian on 20/5/25.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // 1) World-tracking + horizontal plane detection
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        arView.session.run(config)
        
        // 2) Coaching overlay
        let coaching = ARCoachingOverlayView()
        coaching.session = arView.session
        coaching.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coaching.goal = .horizontalPlane
        coaching.activatesAutomatically = true
        arView.addSubview(coaching)
        
        // 3) Tap gesture for placing a box
        let tap = UITapGestureRecognizer(target: context.coordinator,
                                         action: #selector(Coordinator.handleTap(_:)))
        arView.addGestureRecognizer(tap)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject {
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            guard let view = sender.view as? ARView else { return }
            let location = sender.location(in: view)
            
            if let result = view.raycast(from: location,
                                          allowing: .estimatedPlane,
                                          alignment: .horizontal).first {
                
                let boxMesh = MeshResource.generateBox(size: 0.1)
                let material = SimpleMaterial(color: .blue,
                                              roughness: 0.5,
                                              isMetallic: false)
                let boxEntity = ModelEntity(mesh: boxMesh, materials: [material])
                
                // Anchor at the hit location
                let anchor = AnchorEntity(world: result.worldTransform)
                anchor.addChild(boxEntity)
                view.scene.addAnchor(anchor)
            }
        }
    }
}
