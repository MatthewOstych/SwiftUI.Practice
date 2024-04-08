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
                    HStack {
                        Text("Wi-Fi")
                        Spacer()
                        Image(systemName: "wifi")
                    }
                    
                    HStack {
                        Text("Bluetooth")
                        Spacer()
                        Image(systemName: "iphone.gen3.radiowaves.left.and.right")
                    }
                    
                    HStack {
                        Text("Cellular")
                        Spacer()
                        Image(systemName: "cellularbars")
                    }
                }
                
                Section(header: Text("Apps")) {
                    HStack {
                        Text("App Store")
                        Spacer()
                        Image(systemName: "app")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    ContentView()
}
