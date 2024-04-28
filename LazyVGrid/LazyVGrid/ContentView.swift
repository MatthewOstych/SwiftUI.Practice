//
//  ContentView.swift
//  LazyVGrid
//
//  Created by Mathew Lantsov on 27.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    let colums: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    let instaRows: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.white)
                .frame(height: 1)
            ScrollView {
                LazyVGrid(columns: colums,
                          alignment: .center,
                          spacing: nil,
                          pinnedViews: [.sectionHeaders]) {
                    profileSection
                }
                
                storiesSection
                
                LazyVGrid(columns: colums,
                          alignment: .center,
                          spacing: nil,
                          pinnedViews: [.sectionHeaders]) {
                    photoSection
                }
            }
        }
    }

    var storiesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Section {
                LazyHGrid(rows: instaRows) {
                    ForEach(0..<8) { index in
                        Rectangle()
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                    }
                }
            }
            .frame(height: 80)
        }
    }
    
    
    var photoSection: some View {
        Section {
            ForEach(0..<50) { index in
                Rectangle()
                    .frame(height: 150)
            }
        } header: {
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Text("grid")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("reels")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("video")
                }
                Spacer()

            }
            .padding()
            .background(Color.white.ignoresSafeArea(edges: .top))
        }

    }
    
    var profileSection: some View {
        Section {
            VStack {
                Rectangle()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                Text("Dog")
                    .fontWeight(.bold)
            }
            VStack {
                Text("150")
                    .fontWeight(.bold) 
                Text("Подписчики")
                    .fontWeight(.bold)
            } 
            VStack {
                Text("120")
                    .fontWeight(.bold)
                Text("Подписок")
                    .fontWeight(.bold)
            }
        } header: {
            HStack {
                Spacer()
                Text("InstaDog")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            .background(.white)
        }

    }
}

#Preview {
    ContentView()
}
