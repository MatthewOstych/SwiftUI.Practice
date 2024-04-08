import SwiftUI

struct ContentView: View {
    @State var airplaneMode: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $airplaneMode) {
                    Text("Air Mode")
                }
                
                Section(header: Text("Network")) {
                    NavigationLink(destination: WiFiSettingsView()) {
                        HStack {
                            Image(systemName: "wifi")
                            Text("Wi-Fi")
                        }
                    }
                    
                    NavigationLink(destination: BluetoothSettingsView()) {
                        HStack {
                            Image(systemName: "iphone.gen3.radiowaves.left.and.right")
                            Text("Bluetooth")
                            
                        }
                    }
                    
                    NavigationLink(destination: CellularSettingsView()) {
                        HStack {
                            Image(systemName: "cellularbars")
                            Text("Cellular")
                        }
                    }
                }
                
                Section(header: Text("Apps")) {
                    HStack {
                        Image(systemName: "app")
                        Text("App Store")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct WiFiSettingsView: View {
    var body: some View {
        Text("Wi-Fi Settings")
            .navigationTitle("Wi-Fi")
    }
}

struct BluetoothSettingsView: View {
    var body: some View {
        Text("Bluetooth Settings")
            .navigationTitle("Bluetooth")
    }
}

struct CellularSettingsView: View {
    var body: some View {
        Text("Cell Settings")
            .navigationTitle("Cellular")
    }
}

#Preview {
    ContentView()
}
