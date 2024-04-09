//
//  ContentView.swift
//  Brightness Adjuster Slider
//
//  Created by Mathew Lantsov on 09.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State var brightnessValue: Double = 50
    
    var body: some View {
        ZStack {
           Color(white: brightnessValue / 100, opacity: 1.0)
                .ignoresSafeArea()
            VStack {
                Slider(value: $brightnessValue, in: 0...100)
                    .padding()
                Text("Brightness")
            }
            .foregroundStyle(.blue)
        }
    }
}

#Preview {
    ContentView()
}
