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
    @Binding var showRadius: Bool
    var userLocation: CLLocationCoordinate2D?
    var onLongPress: (CLLocationCoordinate2D) -> Void

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        map.showsUserLocation = showsUserLocation
        map.showsScale = true
        map.showsCompass = true
        map.mapType = mapType
        map.showsTraffic = showTraffic

        let lp = UILongPressGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleLongPress(_:))
        )
        map.addGestureRecognizer(lp)

        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.region = region
        uiView.mapType = mapType
        uiView.showsTraffic = showTraffic
        uiView.showsUserLocation = showsUserLocation

        // Annotations
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)

        // Overlays
        uiView.removeOverlays(uiView.overlays)
        if let r = route {
            uiView.addOverlay(r.polyline)
        }
        if showRadius, let loc = userLocation {
            uiView.addOverlay(MKCircle(center: loc, radius: 500))
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        init(_ parent: MapView) { self.parent = parent }

        @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
            guard gesture.state == .began,
                  let mapView = gesture.view as? MKMapView
            else { return }
            let pt = gesture.location(in: mapView)
            let coord = mapView.convert(pt, toCoordinateFrom: mapView)
            parent.onLongPress(coord)
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let poly = overlay as? MKPolyline {
                let r = MKPolylineRenderer(polyline: poly)
                r.strokeColor = .blue
                r.lineWidth = 4
                return r
            }
            if let circle = overlay as? MKCircle {
                let r = MKCircleRenderer(circle: circle)
                r.strokeColor = .red
                r.lineWidth = 2
                r.fillColor = UIColor.red.withAlphaComponent(0.1)
                return r
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
