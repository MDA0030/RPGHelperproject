//
//  ContentView.swift
//
//
//  Created by matt on 10/26/26.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Text("Main Menu")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                NavigationLink(destination: MapView()) {
                    menuButton(title: "Map", icon: "map")
                }

                NavigationLink(destination: GoldView()) {
                    menuButton(title: "Gold", icon: "dollarsign.circle")
                }

                NavigationLink(destination: StrongholdView()) {
                    menuButton(title: "Stronghold", icon: "shield")
                }

                NavigationLink(destination: NPCView()) {
                    menuButton(title: "NPC", icon: "person.2")
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }

    //menu button
    func menuButton(title: String, icon: String) -> some View {
        Label(title, systemImage: icon)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ContentView()
}
