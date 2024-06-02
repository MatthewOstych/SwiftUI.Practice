//
//  TodoToggleButton.swift
//  StateManagment
//
//  Created by Mathew Lantsov on 31.05.2024.
//

import SwiftUI

struct TodoToggleButton: View {
    
   @Binding var state: Bool
    
    var body: some View {
        Button {
            withAnimation {
                state.toggle()
            }
        } label: {
            GeometryReader { proxy in
                ZStack {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .foregroundStyle(.blue)
                
                    if state {
                        Circle()
                            .frame(width: proxy.size.width * 0.8)
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
        .scaledToFit()
    }
}

struct TodoToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        StateFullPreviewWraper(false) { state in
            TodoToggleButton(state: state)
        }
    }
    
    
}
