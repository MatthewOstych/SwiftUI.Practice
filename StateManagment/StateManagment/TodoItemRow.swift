import SwiftUI



struct TodoItemRow: View {
    
  @Binding var item: Todoitem
    
    var body: some View {
        HStack {
            TodoToggleButton(state: $item.isDone)
                .frame(width: 40, height: 40)
                
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .strikethrough(item.isDone)
                
                if let description = item.description {
                    Text(description)
                        .font(.subheadline)
                }
            }
            .padding(.leading)
            Spacer()
        }
        .padding()
        .frame(height: 70)
    }
}

struct TodoItemRow_Previews: PreviewProvider {
    
   @State static var todoitemWithoutDescriptioni = Todoitem(
        id: UUID(),
        title: "Buy some bread",
        isDone: true
    )
    
   @State static var todoitemwithdescription = Todoitem(id: UUID(), title: "Buy some milk", description: "get lactose-free one")
    
    static var previews: some View {
        Group {
            TodoItemRow(item: $todoitemWithoutDescriptioni)
            
            StateFullPreviewWraper(todoitemwithdescription) { Todoitem in
                TodoItemRow(item: Todoitem)
            }
            .previewDisplayName("With descriptuin")
            
            TodoItemRow(item: $todoitemwithdescription)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
