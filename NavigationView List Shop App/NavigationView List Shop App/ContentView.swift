

import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let price: String
}

struct ContentView: View {
    
   @ State var products: [Product] = [
        .init(title: "Peache Shirt", description: "Black", price: "400 eur"),
        .init(title: "Peache Shirt", description: "Black", price: "500 eur"),
        .init(title: "Peache Shirt", description: "Black", price: "700 eur")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(products) { product in
                    NavigationLink(destination: ProductItemView(product: product)) {
                        makeProductCellView(product: product)
                    }
                    .swipeActions(edge: .leading) {
                        Button(role: .destructive) {
                            deleteProduct(product)
                        } label: {
                            Image(systemName: "trash")
                                .tint(.red)
                        }
                    }
                }
                .onMove(perform: moveProduct)
                .listRowSeparator(.hidden)
            }
            
            .refreshable {
                print("refresh")
            }
            .navigationTitle("Shop")
            .toolbar { EditButton() }
        }
    }
    
    func makeProductCellView(product: Product) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.title)
                    .foregroundStyle(.gray)
                    .font(.caption2)
                    .fontWeight(.light)
                    .padding(.bottom)
                Text(product.description)
                    .font(.caption)
                    .fontWeight(.bold)
                Text(product.price)
            }
        }
    }
    
    func moveProduct(from source: IndexSet, to destination: Int) {
        products.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteProduct(_ product: Product) {
        products.removeAll{ $0.id == product.id }
    }
    
}

#Preview {
    ContentView()
}
