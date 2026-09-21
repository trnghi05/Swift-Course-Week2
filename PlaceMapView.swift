import SwiftUI
import MapKit

struct PlaceMapView: View {
    let place: Place
    @State private var region: MKCoordinateRegion

    init(place: Place) {
        self.place = place
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [place]) { item in
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
        }
        .navigationTitle(place.name)
    }
}
