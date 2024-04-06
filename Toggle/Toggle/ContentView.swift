//
//  ContentView.swift
//  Toggle
//
//  Created by Mathew Lantsov on 05.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State var isOnToggle = false
    @State var rectangleColor: Color = .blue
    @State var buttonText = "Something on the screen"
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    VStack {
                        
                        Button(action: changeBackground) {
                            Text("Change Background")
                        }
             
                        Button(action: changeText) {
                            Text("Change text")
                        }
                    } .buttonStyle(.bordered)
                    Spacer()
                }
                Spacer()
                RoundedRectangle(cornerRadius: 50).fill(rectangleColor).offset(x: isOnToggle ? 180 : 0)
                Text(buttonText).offset(x: isOnToggle ? 100 : 0)
            }

            Toggle(isOn: $isOnToggle, label: {
                Text("Show Settings")
            }).padding()
                .toggleStyle(.button)
            
            
        }.animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3))
        .padding()
    }
    
    func changeText() {
        if buttonText == "New text" {
            buttonText = "Something on the screen"
        } else {
            buttonText = "New text"
        }
    }
    
    func changeBackground() {
        if rectangleColor == .blue {
            rectangleColor = .green // Change to any color you like
        } else {
            rectangleColor = .blue
        }
    }
}

#Preview {
    ContentView()
}
