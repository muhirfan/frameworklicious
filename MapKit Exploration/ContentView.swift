//
//  ContentView.swift
//  MapKit Exploration
//
//  Created by Kaushik Manian on 29/4/25.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    @State private var annotations: [MKPointAnnotation] = {
        let gg = MKPointAnnotation()
        gg.title = "Golden Gate Bridge"
        gg.coordinate = CLLocationCoordinate2D(latitude: 37.8199, longitude: -122.4783)

        let al = MKPointAnnotation()
        al.title = "Alcatraz Island"
        al.coordinate = CLLocationCoordinate2D(latitude: 37.8267, longitude: -122.4230)

        return [gg, al]
    }()

    @State private var route: MKRoute?
    @State private var searchText = ""
    @State private var poiQuery = ""
    @State private var mapType: MKMapType = .standard
    @State private var showTraffic = false

    /// Only recenter once when live location arrives
    @State private var didCenterOnUser = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // ───────── Map ─────────
                MapView(
                    region: $region,
                    annotations: annotations,
                    route: route,
                    showsUserLocation: true,
                    mapType: $mapType,
                    showTraffic: $showTraffic,
                    userLocation: locationManager.location?.coordinate
                ) { coord in
                    let pin = MKPointAnnotation()
                    pin.coordinate = coord
                    pin.title = "Dropped Pin"
                    annotations.append(pin)
                }
                .frame(height: 350)

                // ───────── Controls ─────────
                VStack(spacing: 8) {
                    HStack {
                        TextField("Geocode address", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                        Button("Go") { geocode(address: searchText) }
                            .disabled(searchText.isEmpty)
                    }

                    HStack {
                        TextField("Search POI (e.g. café)", text: $poiQuery)
                            .textFieldStyle(.roundedBorder)
                        Button("Search") { searchPOI() }
                            .disabled(poiQuery.isEmpty)
                    }

                    Picker("Map Style", selection: $mapType) {
                        Text("Standard").tag(MKMapType.standard)
                        Text("Satellite").tag(MKMapType.satellite)
                        Text("Hybrid").tag(MKMapType.hybrid)
                    }
                    .pickerStyle(.segmented)

                    Toggle("Traffic", isOn: $showTraffic)
                }
                .padding()

                // ───────── Help Text ─────────
                VStack(alignment: .leading, spacing: 4) {
                    Text("Help").font(.headline)
                    Text("• POI = Point of Interest (cafés, parks, shops).")
                    Text("• Geocode Address: type an address to drop a pin there.")
                    Text("• Route: goes from your live location to the nearest pin.")
                }
                .font(.footnote)
                .padding(.horizontal)
                .padding(.bottom)

                Spacer()
            }
            .navigationTitle("MapKit Demo")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Reset") { resetAll() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Route") { makeRoute() }
                }
            }
        }
        // Recenter on live location **once** when it arrives
        .onChange(of: locationManager.location) { newLoc in
            guard let loc = newLoc, !didCenterOnUser else { return }
            region = MKCoordinateRegion(
                center: loc.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
            didCenterOnUser = true
        }
    }

    private func geocode(address: String) {
        CLGeocoder().geocodeAddressString(address) { placemarks, _ in
            guard let loc = placemarks?.first?.location else { return }
            let pin = MKPointAnnotation()
            pin.coordinate = loc.coordinate
            pin.title = address
            annotations.append(pin)
            region.center = loc.coordinate
        }
    }

    private func searchPOI() {
        let req = MKLocalSearch.Request()
        req.naturalLanguageQuery = poiQuery
        req.region = region

        MKLocalSearch(request: req).start { resp, _ in
            guard let items = resp?.mapItems else { return }
            for item in items.prefix(10) {
                let pin = MKPointAnnotation()
                pin.coordinate = item.placemark.coordinate
                pin.title = item.name
                annotations.append(pin)
            }
        }
    }

    private func makeRoute() {
        guard let userLoc = locationManager.location else { return }
        // Find nearest annotation to the user
        guard let nearest = annotations.min(by: { a, b in
            let la = CLLocation(latitude: a.coordinate.latitude, longitude: a.coordinate.longitude)
            let lb = CLLocation(latitude: b.coordinate.latitude, longitude: b.coordinate.longitude)
            return la.distance(from: userLoc) < lb.distance(from: userLoc)
        }) else { return }

        let src = MKMapItem(placemark: MKPlacemark(coordinate: userLoc.coordinate))
        let dst = MKMapItem(placemark: MKPlacemark(coordinate: nearest.coordinate))

        let req = MKDirections.Request()
        req.source = src
        req.destination = dst
        req.transportType = .automobile

        MKDirections(request: req).calculate { resp, _ in
            guard let r = resp?.routes.first else { return }
            route = r
            // Zoom to show entire route
            region = MKCoordinateRegion(r.polyline.boundingMapRect)
        }
    }

    /// Clears all pins back to the two defaults and removes the route
    private func resetAll() {
        annotations = {
            let gg = MKPointAnnotation()
            gg.title = "Golden Gate Bridge"
            gg.coordinate = CLLocationCoordinate2D(latitude: 37.8199, longitude: -122.4783)
            let al = MKPointAnnotation()
            al.title = "Alcatraz Island"
            al.coordinate = CLLocationCoordinate2D(latitude: 37.8267, longitude: -122.4230)
            return [gg, al]
        }()
        route = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
