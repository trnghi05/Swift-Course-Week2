import SwiftUI

struct ContentView: View {
    @State private var places: [Place] = [
        Place(name: "HCMUTE", latitude: 10.8506, longitude: 106.7719),
        Place(name: "Home", latitude: 10.9500, longitude: 106.8200),
        Place(name: "Coffee Shop", latitude: 10.8752, longitude: 106.8012),
        Place(name: "Park", latitude: 10.8601, longitude: 106.7930)
    ]
    
    @State private var searchText = ""
    @State private var isShowingAddSheet = false
    
    var filteredPlaces: [Place] {
        if searchText.isEmpty {
            return places
        } else {
            return places.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("🔍 Search places...", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // List of Places
                List {
                    ForEach(filteredPlaces) { place in
                        NavigationLink(destination: PlaceMapView(place: place)) {
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundColor(.red)
                                
                                VStack(alignment: .leading) {
                                    Text(place.name).font(.headline)
                                    Text("\(place.latitude, specifier: "%.4f"), \(place.longitude, specifier: "%.4f")")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deletePlace)
                }
                
                // Add Button
                Button(action: { isShowingAddSheet.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add New Place")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                // Total Count
                Text("Total: \(places.count) places")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.vertical, 8)
            }
            .navigationTitle("My Places")
            .sheet(isPresented: $isShowingAddSheet) {
                AddPlaceView { newPlace in
                    places.append(newPlace)
                }
            }
        }
    }
    
    func deletePlace(at offsets: IndexSet) {
        places.remove(atOffsets: offsets)
    }
}
