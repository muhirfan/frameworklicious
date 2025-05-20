//
//  MapView.swift
//  MapKit Exploration
//
//  Created by Kaushik Manian on 29/4/25.
//

import Foundation
import SwiftUI
import MapKit
import UIKit

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var annotations: [MKPointAnnotation]
    var route: MKRoute?
    var showsUserLocation: Bool

    @Binding var mapType: MKMapType
    @Binding var showTraffic: Bool
    var userLocation: CLLocationCoordinate2D?
    var onLongPress: (CLLocationCoordinate2D) -> Void

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        map.mapType = mapType
        map.showsTraffic = showTraffic
        map.showsUserLocation = showsUserLocation
        map.showsScale = true
        map.showsCompass = true
        map.setRegion(region, animated: false)

        let lp = UILongPressGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleLongPress(_:))
        )
        map.addGestureRecognizer(lp)
        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if uiView.mapType != mapType { uiView.mapType = mapType }
        if uiView.showsTraffic != showTraffic { uiView.showsTraffic = showTraffic }
        if uiView.showsUserLocation != showsUserLocation { uiView.showsUserLocation = showsUserLocation }

        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)

        uiView.removeOverlays(uiView.overlays)
        if let r = route {
            uiView.addOverlay(r.polyline)
        }

        if !context.coordinator.isRegionUpdating {
            uiView.setRegion(region, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        var isRegionUpdating = false

        init(_ parent: MapView) { self.parent = parent }

        @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
            guard gesture.state == .began,
                  let map = gesture.view as? MKMapView else { return }
            let pt = gesture.location(in: map)
            let coord = map.convert(pt, toCoordinateFrom: map)
            parent.onLongPress(coord)
        }

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            isRegionUpdating = true
            parent.region = mapView.region
            isRegionUpdating = false
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let poly = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: poly)
                renderer.strokeColor = .systemBlue
                renderer.lineWidth = 8 
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
