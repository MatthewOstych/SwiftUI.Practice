//
//  BasketView.swift
//  SegmentSwiftUI
//
//  Created by Mathew Lantsov on 23.04.2024.
//

import SwiftUI

struct BasketView: View {
    var sneakers = ""
    var gender = ""
    
    @State private var alertPresented = false
    @State var adress = ""
    @State var progress = 0.5
    @FocusState var adressFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("Order Progress")
                ProgressView(value: progress)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 0)
            }
            
            Text("You added to busket \(sneakers) for \(gender)")
            Spacer()
            Text("Put your adress:")
            
            TextField("Put adress", text: $adress)
                .padding()
                .focused($adressFocused)
                .modifier(TextFieldModified())
                .padding(.horizontal, 25)
            Button {
                adressFocused = false
                alertPresented = true
            } label: {
                Text("Order")
            }
            
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.blue)
            .cornerRadius(17)
            .padding(.horizontal, 25)
            
            Spacer()
        }
        .padding(.top, 20)
        
        .alert(isPresented: $alertPresented) {
            Alert(
                title: Text("Your order is coplete"),
                message: Text(allertMessage)
                
            )
        }
    }
    
    var allertMessage: String {
        if adress.isEmpty {
            return "No address provided."
        } else {
            return "Address is \(adress)."
        
    
        }
    }
    
    struct TextFieldModified: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.footnote)
                .padding(1)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 2)
                )
                .foregroundColor(Color.black)
            
        }
    }
}

#Preview {
    BasketView()
}

