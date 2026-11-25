//
//  Gold.swift
//
//
//  Created by matt on 10/26/26.
//


import SwiftUI


struct GoldView: View {
    //gem amounts
    @State private var rubyAmt = 0
    @State private var saphAmt = 0
    @State private var emeraldAmt = 0
    @State private var diamondAmt = 0
    @State private var pearlAmt = 0

    //coin amounts
    @State private var platinumCoin = 0
    @State private var silverCoin = 0
    @State private var copperCoin = 0
    @State private var goldCoin = 0

    //treasure result
    @State private var treasure = "None"

    //dictionary of possible magical items to be pseduorandom selected
    private let treasureDict: [Int: String] = [
        1: "None",
        2: "Axe+1",
        3: "Mace+1",
        4: "Long sword+1",
        5: "Short sword+1",
        6: "Staff+1",
        7: "Axe+2",
        8: "Mace+2",
        9: "Long sword+2",
        10: "Short sword+2",
        11: "Staff+2",
        12: "Shield+2",
        13: "Mace+3",
        14: "Long sword+3",
        15: "Short sword+3",
        16: "Staff+3",
        17: "Ring+1",
        18: "Magical bag",
        19: "Shield+1",
        20: "Spell scroll",
        21: "Ring+2",
        22: "Magical potion",
        23: "Spell book",
        24: "Leather armor +1",
        25: "2 magical potions",
        26: "Chainmail+1",
        27: "Magical potion",
        28: "Shield+3",
        29: "Plate mail+2",
        30: "Chainmail+2",
        31: "Leather armor+2",
        32: "Plate mail+3",
        33: "Magical potion",
        34: "Leather armor+3",
        35: "Chainmail+3",
        36: "Spell book",
        37: "Magical cloak",
        38: "Magical boots",
        39: "Shield+1",
        40: "Magical dust",
        41: "Plate mail+1",
        42: "Axe+3",
        44: "Ring+3",
        45: "Magical necklace",
        46: "3 magical potions",
        47: "Healing potion",
        48: "2 healing elixirs",
        49: "Magical bottle",
        50: "Magical map",
        51: "Magical amulet"
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                Text("Treasure Generator")
                    .font(.largeTitle.bold())

                //selection of coins for DM
                resultSection(title: "Coins", items: [
                    ("Platinum", platinumCoin),
                    ("Gold", goldCoin),
                    ("Silver", silverCoin),
                    ("Copper", copperCoin)
                ])

                //selection of gems available for DM
                resultSection(title: "Gems", items: [
                    ("Ruby", rubyAmt),
                    ("Sapphire", saphAmt),
                    ("Emerald", emeraldAmt),
                    ("Diamond", diamondAmt),
                    ("Pearl", pearlAmt)
                ])

                //background for treasure display
                VStack(alignment: .leading, spacing: 8) {
                    Text("Treasure")
                        .font(.title2.bold())

                    Text(treasure)
                        .font(.headline)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding()
                        .background(
                            Color.yellow.opacity(0.15)
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                }

                //button for gold and other coins
                Button(action: rollCoins) {
                    Label(
                        "Roll Coins",
                        systemImage: "dice.fill"
                    )
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 14)
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Gold")
        .navigationBarTitleDisplayMode(.inline)
    }


    private func resultSection(
        title: String,
        items: [(String, Int)]
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2.bold())

            ForEach(items, id: \.0) { item in
                HStack {
                    Text(item.0)

                    Spacer()

                    Text("\(item.1)")
                        .monospacedDigit()
                        .bold()
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }


    private func rollCoins() {
        //pseudorandom gem amounts
        let randomIntRuby = Int.random(in: 0..<1000)
        let randomIntSaph = Int.random(in: 0..<1000)
        let randomIntEmerald = Int.random(in: 0..<980)
        let randomIntDiamond = Int.random(in: 0..<941)
        let randomIntPearl = Int.random(in: 0..<941)

        rubyAmt = randomIntRuby >= 735
            ? (randomIntRuby / 11) / 3 : 0

        saphAmt = randomIntSaph >= 821
            ? (randomIntSaph / 11) / 3 : 0

        emeraldAmt = randomIntEmerald >= 905
            ? (randomIntEmerald / 11) / 3 : 0

        diamondAmt = randomIntDiamond >= 900
            ? randomIntDiamond / 4 : 0

        pearlAmt = randomIntPearl >= 840
            ? randomIntPearl / 7 : 0

        //pseudorandom coin amounts
        goldCoin = Int.random(in: 0..<2001)
        platinumCoin = Int.random(in: 0..<504)
        copperCoin = Int.random(in: 0..<2891)
        silverCoin = Int.random(in: 0..<4003)

        // pseudorandom treasure
        let randomIntTreas = Int.random(in: 0..<504)

        if randomIntTreas >= 453 {
            let treasureRoll = Int.random(in: 1...51)
            treasure = treasureDict[treasureRoll] ?? "None"
        } else {
            treasure = "None"
        }
    }
}


#Preview {
    NavigationStack {
        GoldView()
    }
}
