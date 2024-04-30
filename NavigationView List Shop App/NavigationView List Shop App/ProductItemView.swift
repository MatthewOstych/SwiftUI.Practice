//
//  ProductItemView.swift
//  NavigationView List Shop App
//
//  Created by Mathew Lantsov on 28.04.2024.
//

import SwiftUI

struct ProductItemView: View {
    let product: Product
    @State var goodQuantity = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                List{
                    Section {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Name - \(product.title)")
                                .font(.title)
                                .fontWeight(.medium)
                            Text("Price - " + product.price)
                            Text("Description: " + product.description)
                        }
                        .padding(.vertical, 10)
                    }
                    
                    Section {
                                QuantitySelector(quantity: $goodQuantity)
                        
                    }
                }
                
                NavigationLink(destination: BusketView(product: product, quantity: goodQuantity)) {
                    Text("Add")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
                .padding(.bottom)
            }
        }
    }
}

#Preview {
    ProductItemView(product: .init(title: "No", description: "No descriptioin", price: "0"))
}

struct QuantitySelector: View {
    @Binding var quantity: Int

    var body: some View {
        HStack {
            Text("Quantity")
            Spacer()
            

            Button(action: {
                if quantity > 1 {
                    quantity -= 1
                    print("Уменьшено: \(quantity)")
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())

            Text("\(quantity)")
                .font(.title2)
                .padding(.horizontal)

            Button(action: {
                quantity += 1
                print("Увеличено: \(quantity)")
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
            }
            .buttonStyle(BorderlessButtonStyle())
          
        }
    }
}
