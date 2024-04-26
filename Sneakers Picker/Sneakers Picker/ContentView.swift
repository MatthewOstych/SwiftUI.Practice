//
//  ContentView.swift
//  SegmentSwiftUI
//
//  Created by Mathew Lantsov on 11.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView() {
            MainView()
                .tabItem {
                    Label("Main", systemImage: "globe")
                }
                .tag(0)
            
            
        }
    }
}

#Preview {
    ContentView()
}
