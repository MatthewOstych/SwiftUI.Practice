//
//  ContentView.swift
//  SPR
//
//  Created by Mathew Lantsov on 04.04.2024.
//

import SwiftUI

enum Chouces: String, CaseIterable {
    case Scissors = "✂️", Paper = "📃", Rock = "🪨"
}

struct ContentView: View {
    
    @State var computerChoise = Chouces.allCases.first!
    @State var gameOutcome = ""
    
    @State var wins = 0
    @State var round = 0
    
    @State var showAlert = false
    @State var showComputerChoise = false
    
    var body: some View {
        GeometryReader {geo in
            VStack {  
                
                //Computer
                VStack {
                    if !showComputerChoise {
                        Text("🤖")
                            .font(.system(size: 100))
                    } else {
                        Text(computerChoise.rawValue)
                            .font(.system(size: 100))
                    }
                }.frame(width: geo.size.width, height: geo.size.height/2)
                
                //Player
                VStack {
                    Text("Make your selecion:")
                        .padding()
                    HStack(spacing: 0) {
                        
                        ForEach(Chouces.allCases, id: \.self) {option in
                            Button(action: {
                                //Start The Rund
                                round += 1
                                
                                //Generate a computer choise
                                let index = Int.random(in: 0...Chouces.allCases.count - 1)
                                computerChoise = Chouces.allCases[index]
                                showComputerChoise = true
                                
                                // Check if win
                                checkWin(playerChoice: option)
                            }){
                                Text(option.rawValue)
                                    .font(.system(size: geo.size.width/CGFloat(Chouces.allCases.count)))
                            }
                            
                        }
                    }
                    HStack{
                        Spacer()
                        Text("Wins: \(wins)")
                        Spacer()
                        Text("Round: \(round)")
                        Spacer()
                    }
                }.frame(width: geo.size.width, height: geo.size.height/2)
            }
        }
        
        .alert("You \(gameOutcome)!", isPresented: $showAlert){
            Button("Play again!", role: .cancel){showComputerChoise = false }
        }
        
    }
    
    func checkWin(playerChoice:Chouces) {
        
        switch playerChoice {
        case .Scissors:
            if computerChoise == .Scissors {
                gameOutcome = "Draw"
            } else if computerChoise == .Paper {
                gameOutcome = "Win"
                wins += 1
            } else {
                gameOutcome = "Lose"
            }
        case .Paper:
            if computerChoise == .Scissors {
                gameOutcome = "Lose"
            } else if computerChoise == .Paper {
                gameOutcome = "Draw"
            } else {
                gameOutcome = "Win"
                wins += 1
            }
        case .Rock:
            if computerChoise == .Scissors {
                gameOutcome = "Win"
                wins += 1
            } else if computerChoise == .Paper {
                gameOutcome = "Draw"
            } else {
                gameOutcome = "Lose"
            }
        }
        showAlert = true
    }
}

#Preview {
    ContentView()
}
