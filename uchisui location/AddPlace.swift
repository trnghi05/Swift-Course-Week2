import SwiftUI

struct AddPlaceView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var latString: String = ""
    @State private var lonString: String = ""
    
    var onSave: (Place) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Place Information")) {
                    TextField("Name", text: $name)
                    TextField("Latitude", text: $latString).keyboardType(.decimalPad)
                    TextField("Longitude", text: $lonString).keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add New Place")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let lat = Double(latString), let lon = Double(lonString), !name.isEmpty {
                            let newPlace = Place(name: name, latitude: lat, longitude: lon)
                            onSave(newPlace)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
