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
        let gg = MKPointAnnotation(); gg.title = "Golden Gate Bridge";
        gg.coordinate = CLLocationCoordinate2D(latitude: 37.8199, longitude: -122.4783)
        let al = MKPointAnnotation(); al.title = "Alcatraz Island";
        al.coordinate = CLLocationCoordinate2D(latitude: 37.8267, longitude: -122.4230)
        return [gg, al]
    }()
    @State private var route: MKRoute?
    @State private var searchText = ""
    @State private var poiQuery = ""
    @State private var mapType: MKMapType = .standard
    @State private var showTraffic = false
    @State private var showControlPanel = true
    @State private var didCenterOnUser = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                // Map
                MapView(
                    region: $region,
                    annotations: annotations,
                    route: route,
                    showsUserLocation: true,
                    mapType: $mapType,
                    showTraffic: $showTraffic,
                    userLocation: locationManager.location?.coordinate
                ) { coord in
                    let pin = MKPointAnnotation(); pin.coordinate = coord; pin.title = "Dropped Pin"
                    annotations.append(pin)
                }
                .edgesIgnoringSafeArea(.all)

                // Map Type Selector
                HStack {
                    Spacer()
                    Picker("", selection: $mapType) {
                        Text("Standard").tag(MKMapType.standard)
                        Text("Satellite").tag(MKMapType.satellite)
                        Text("Hybrid").tag(MKMapType.hybrid)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(6)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(.top, 50)
                    Spacer()
                }

                // Control Panel as Bottom Sheet
                VStack(spacing: 0) {
                    Spacer()
                    ControlPanel(
                        searchText: $searchText,
                        poiQuery: $poiQuery,
                        showTraffic: $showTraffic,
                        showControlPanel: $showControlPanel,
                        onGeocode: { geocode(address: searchText) },
                        onPOI: { searchPOI() },
                        onRoute: { makeRoute() },
                        onReset: { resetAll() }
                    )
                    .animation(.spring(), value: showControlPanel)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("MapKit Explorer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: centerOnUser) {
                        Image(systemName: "location.fill").foregroundColor(.blue)
                    }
                }
            }
            .onChange(of: locationManager.location) { newLoc in
                guard let loc = newLoc, !didCenterOnUser else { return }
                region.center = loc.coordinate
                didCenterOnUser = true
            }
        }
    }

    // MARK: - Location Actions
    private func centerOnUser() {
        if let userLocation = locationManager.location?.coordinate {
            withAnimation {
                region = MKCoordinateRegion(
                    center: userLocation,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            }
        }
    }

    // MARK: - Geocoding
    private func geocode(address: String) {
        CLGeocoder().geocodeAddressString(address) { placemarks, _ in
            guard let loc = placemarks?.first?.location else { return }
            let pin = MKPointAnnotation(); pin.coordinate = loc.coordinate; pin.title = address
            annotations.append(pin)
            withAnimation { region.center = loc.coordinate }
        }
    }

    // MARK: - POI Search
    private func searchPOI() {
        let req = MKLocalSearch.Request(); req.naturalLanguageQuery = poiQuery; req.region = region
        MKLocalSearch(request: req).start { resp, _ in
            guard let items = resp?.mapItems else { return }
            for item in items.prefix(10) {
                let pin = MKPointAnnotation(); pin.coordinate = item.placemark.coordinate; pin.title = item.name
                annotations.append(pin)
            }
        }
    }

    // MARK: - Routing
    private func makeRoute() {
        guard let userLoc = locationManager.location else { return }
        guard let nearest = annotations.min(by: {
            CLLocation(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
                .distance(from: userLoc)
            < CLLocation(latitude: $1.coordinate.latitude, longitude: $1.coordinate.longitude)
                .distance(from: userLoc)
        }) else { return }

        let src = MKMapItem(placemark: MKPlacemark(coordinate: userLoc.coordinate))
        let dst = MKMapItem(placemark: MKPlacemark(coordinate: nearest.coordinate))
        let req = MKDirections.Request(); req.source = src; req.destination = dst; req.transportType = .automobile
        MKDirections(request: req).calculate { resp, _ in
            guard let r = resp?.routes.first else { return }
            route = r
            withAnimation { region = MKCoordinateRegion(r.polyline.boundingMapRect) }
        }
    }

    // MARK: - Reset
    private func resetAll() {
        annotations = {
            let gg = MKPointAnnotation(); gg.title = "Golden Gate Bridge"; gg.coordinate = CLLocationCoordinate2D(latitude: 37.8199, longitude: 122.4783)
            let al = MKPointAnnotation(); al.title = "Alcatraz Island"; al.coordinate = CLLocationCoordinate2D(latitude: 37.8267, longitude: -122.4230)
            return [gg, al]
        }()
        route = nil
    }
}

// MARK: - Control Panel View
struct ControlPanel: View {
    @Binding var searchText: String
    @Binding var poiQuery: String
    @Binding var showTraffic: Bool
    @Binding var showControlPanel: Bool
    var onGeocode: () -> Void
    var onPOI: () -> Void
    var onRoute: () -> Void
    var onReset: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Text("Search & Controls").font(.headline)
                Spacer()
                Button {
                    withAnimation { showControlPanel.toggle() }
                } label: {
                    Image(systemName: showControlPanel ? "chevron.compact.down" : "chevron.compact.up")
                        .padding(8).background(.ultraThinMaterial).clipShape(Circle())
                }
            }

            if showControlPanel {
                VStack(spacing: 12) {
                    // Address Search
                    HStack {
                        Image(systemName: "mappin.and.ellipse").foregroundColor(.blue)
                        TextField("Search address", text: $searchText)
                            .padding(10).background(.ultraThinMaterial).cornerRadius(8)
                        Button("Go") { onGeocode() }
                            .disabled(searchText.isEmpty)
                            .padding(.vertical, 8).padding(.horizontal, 12)
                            .background(searchText.isEmpty ? Color.gray.opacity(0.3) : Color.blue)
                            .foregroundColor(.white).cornerRadius(8)
                    }
                    // POI Search
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundColor(.green)
                        TextField("Nearby (café, park)", text: $poiQuery)
                            .padding(10).background(.ultraThinMaterial).cornerRadius(8)
                        Button("Find") { onPOI() }
                            .disabled(poiQuery.isEmpty)
                            .padding(.vertical, 8).padding(.horizontal, 12)
                            .background(poiQuery.isEmpty ? Color.gray.opacity(0.3) : Color.green)
                            .foregroundColor(.white).cornerRadius(8)
                    }
                    // Traffic Toggle
                    Toggle(isOn: $showTraffic) {
                        Label("Show Traffic", systemImage: "car.fill")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    // Action Buttons
                    HStack {
                        Button(action: { onReset() }) {
                            Label("Reset", systemImage: "arrow.counterclockwise")
                                .frame(maxWidth: .infinity)
                                .padding().background(.red.opacity(0.8)).foregroundColor(.white).cornerRadius(10)
                        }
                        Button(action: { onRoute() }) {
                            Label("Route", systemImage: "arrow.triangle.turn.up.right.diamond.fill")
                                .frame(maxWidth: .infinity)
                                .padding().background(.blue).foregroundColor(.white).cornerRadius(10)
                        }
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
