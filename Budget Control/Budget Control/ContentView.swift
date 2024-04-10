import SwiftUI

class BudgetManager : ObservableObject {
    @Published var dailyBudget : Double = 0.0 {
        didSet {adjustBudgets() }
    }
    @Published var foodBudget : Double = 0.0 {
        didSet {
            adjustFoodAndTransportBudgets()
            countFreeMoney()
        }
    }
    @Published var transportBudget : Double = 0.0 {
        didSet {
            adjustFoodAndTransportBudgets()
            countFreeMoney()
        }
    }
    var initialDailyBudget: Double = 0.0
    @Published var freeMoney = 0.0
    
    func adjustBudgets() {
        let totalBudget = foodBudget + transportBudget
        if totalBudget > dailyBudget {

            let foodRatio = foodBudget / totalBudget
            let transportRatio = transportBudget / totalBudget
            foodBudget = dailyBudget * foodRatio
            transportBudget = dailyBudget * transportRatio
        }
        countFreeMoney()
    }
    
    func adjustFoodAndTransportBudgets() {
        let totalBudget = foodBudget + transportBudget
        if totalBudget > dailyBudget {
      
        }
    }
    
    func countFreeMoney() -> Double {
        freeMoney = dailyBudget - foodBudget - transportBudget
        return freeMoney
    }
}


struct ContentView: View {
    @StateObject var budgetManager = BudgetManager()
    
    var body: some View {
        //Daily Budget
        VStack {
            HStack {
                Text(" \(budgetManager.freeMoney, specifier: "%.2f")")
                    .bold()
                    .font(.title)
                Text("Free Money")
                    .font(.system(size: 28))
                    .padding()
            }

            
        }
        //Daily Budget
        VStack {
            HStack {
                Text(" \(budgetManager.dailyBudget, specifier: "%.2f")")
                    .bold()
                    .font(.title)
                Text("💵 Daily Budget")
                    .font(.system(size: 28))
                    .padding()
            }
            Slider(value: $budgetManager.dailyBudget, in: 0...1000, step: 1)
                .onChange(of: budgetManager.dailyBudget) { oldValue, newValue in
                    budgetManager.initialDailyBudget = newValue
                }
            
        }
        .padding()
        
        //Food Budget
        VStack {
            HStack {
                Text(" \(budgetManager.foodBudget, specifier: "%.2f")")
                    .bold()
                    .font(.title)
                Text("🍔 Food Budget")
                    .font(.system(size: 28))
                    .padding()
            }
            Slider(value: $budgetManager.foodBudget, in: 0...1000, step: 1)
                .onChange(of: budgetManager.foodBudget) { newValue in
                    let totalBudget = budgetManager.foodBudget + budgetManager.transportBudget
                    if totalBudget > budgetManager.dailyBudget {
                        budgetManager.foodBudget = max(budgetManager.dailyBudget - budgetManager.transportBudget, 0)
                    }
                    
                }
                .padding()
            
            //Transport Budget
            VStack {
                HStack {
                    Text(" \(budgetManager.transportBudget, specifier: "%.2f")")
                        .bold()
                        .font(.title)
                    Text("🚢 Transport Budget")
                        .font(.system(size: 28))
                        .padding()
                }
                Slider(value: $budgetManager.transportBudget, in: 0...1000, step: 1)
                    .onChange(of: budgetManager.transportBudget) { newValue in
                        let totalBudget = budgetManager.foodBudget + budgetManager.transportBudget
                        if totalBudget > budgetManager.dailyBudget {
                            budgetManager.transportBudget = max(budgetManager.dailyBudget - budgetManager.foodBudget, 0)
                        }
                    }
            }
            .padding()
        }
    }
}
#Preview {
    ContentView()
}
