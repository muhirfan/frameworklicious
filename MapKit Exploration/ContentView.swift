//
//  ContentView.swift
//  MapKit Exploration
//
//  Created by Kaushik Manian on 29/4/25.
//

import SwiftUI
import SwiftUI
import MapKit

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
    @State private var showRadius = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                MapView(
                    region: $region,
                    annotations: annotations,
                    route: route,
                    showsUserLocation: true,
                    mapType: $mapType,
                    showTraffic: $showTraffic,
                    showRadius: $showRadius,
                    userLocation: locationManager.location?.coordinate,
                    onLongPress: { coord in
                        let pin = MKPointAnnotation()
                        pin.coordinate = coord
                        pin.title = "Dropped Pin"
                        annotations.append(pin)
                    }
                )
                .frame(height: 350)

                // Controls
                VStack(spacing: 8) {
                    HStack {
                        TextField("Geocode address", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                        Button("Go") { geocode(address: searchText) }
                            .disabled(searchText.isEmpty)
                    }

                    HStack {
                        TextField("Search POI", text: $poiQuery)
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

                    HStack {
                        Toggle("Traffic", isOn: $showTraffic)
                        Toggle("Show Radius", isOn: $showRadius)
                    }
                }
                .padding()

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
        .onAppear {
            // center on user if available
            if let loc = locationManager.location {
                region.center = loc.coordinate
            }
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
        guard annotations.count >= 2 else { return }
        let src = MKMapItem(placemark: MKPlacemark(coordinate: annotations[0].coordinate))
        let dst = MKMapItem(placemark: MKPlacemark(coordinate: annotations[1].coordinate))
        let req = MKDirections.Request()
        req.source = src
        req.destination = dst
        req.transportType = .automobile

        MKDirections(request: req).calculate { resp, _ in
            guard let r = resp?.routes.first else { return }
            route = r
        }
    }

    private func resetAll() {
        route = nil
        annotations = Array(annotations.prefix(2))
        region = MKCoordinateRegion(
            center: annotations[0].coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        searchText = ""
        poiQuery = ""
        mapType = .standard
        showTraffic = false
        showRadius = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
