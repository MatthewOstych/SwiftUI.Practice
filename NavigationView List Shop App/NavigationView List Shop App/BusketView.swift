//
//  busketView.swift
//  NavigationView List Shop App
//
//  Created by Mathew Lantsov on 30.04.2024.
//

import SwiftUI

struct BusketView: View {
    let product: Product
    let quantity: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    List {
                        Section {
                            Text("Name - \(product.title)")
                                .font(.title)
                                .fontWeight(.medium)
                            Text("Price - " + product.price)
                            Text("Description: " + product.description)
                        }
                        
                        Section {
                            Text("Quantity - " + String(quantity))
                        }
         
                    }
                }
            }
            .navigationTitle("Busket")
        }
    }
}

#Preview {
    BusketView(product: .init(title: "No title", description: "No Description", price: "0"),quantity: 0)
}
