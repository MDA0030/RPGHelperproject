//
//  Stronghold.swift
//
//
//  Created by matt on 10/26/26.
//

import SwiftUI

struct StrongholdView: View {

    @State private var strongholdType = ""
    @State private var strongholdWall = ""
    @State private var strongholdTower = ""
    @State private var strongholdUnique = ""
    @State private var strongholdForge = ""
    @State private var strongholdTime = 0
    @State private var strongholdCost = 0
    
    //button to choose random stronghold addition
    private func strongholdButton() {

        let strongTypes = [
            "Samurai Shogun Castle",
            "Large Wooden Fort",
            "Viking wooden Fortress",
            "Medium Stone Keep",
            "Large Stone Keep",
            "Grand Stone Castle",
            "Wizard Tower"
        ]

        let strongWalls = [
            "Small wall",
            "Medium wall",
            "Large wall",
            "2 small walls"
        ]

        let strongTowers = [
            "Small tower",
            "Medium tower",
            "Large tower",
            "2 small towers"
        ]

        let strongUniques = [
            "Alchemy lab",
            "Library",
            "Stable",
            "Guard barracks"
        ]

        let strongForges = [
            "Forge",
            "Armory"
        ]

        // randomly select stronghold attributes
        strongholdType = strongTypes.randomElement()!
        strongholdWall = strongWalls.randomElement()!
        strongholdTower = strongTowers.randomElement()!
        strongholdUnique = strongUniques.randomElement()!
        strongholdForge = strongForges.randomElement()!

        // generate random time in days and money cost for player to build
        strongholdTime = Int.random(in: 30...90)

        let randomCost = Int.random(in: 4000..<31000)
        strongholdCost = randomCost / 2
    }
    
    
    var body: some View {
        VStack(spacing: 16) {

            Text("Stronghold Generator")
                .font(.largeTitle)
                .fontWeight(.bold)

            Divider()

            Text("Cost: \(strongholdCost)")
            Text("Type: \(strongholdType)")
            Text("Wall: \(strongholdWall)")
            Text("Tower: \(strongholdTower)")
            Text("Unique: \(strongholdUnique)")
            Text("Forge: \(strongholdForge)")
            Text("Time: \(strongholdTime)")

            Button(action: strongholdButton) {
                Text("Generate Stronghold")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
            }
        }
        .padding()
        .navigationTitle("Stronghold")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    NavigationStack {
        StrongholdView()
    }
}
