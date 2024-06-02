
import SwiftUI

struct TodoItemsListView: View {
        
    @StateObject var viewModel = TodoItemsListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($viewModel.todoItems) { $todoItems in
                    TodoItemRow(item: $todoItems.onNewValue {
                        viewModel.reorder()
                    })
                }
                .onDelete(perform: viewModel.deleteItems(at:))
                .onMove(perform:viewModel.moveItems(from:to:))
            }
            .listStyle(.automatic)
            .navigationTitle("Today's Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
            }
            .onAppear {
                viewModel.loadItems()
            }
        }
    }
}

#Preview {
    TodoItemsListView()
}
