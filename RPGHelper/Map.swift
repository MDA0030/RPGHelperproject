//
//  Map.swift
//
//
//  Created by matt on 10/26/26.
//


import SwiftUI


struct MapView: View {

    // selected map environment
    @State private var selectedEnvironment = "city"

    // map generated 100 tiles
    @State private var randomMap: [String] = []

    private let tileSize: CGFloat = 50

    private let environments = [
        ("city", "City"),
        ("forest/grass", "Forest / Grass"),
        ("river/lake", "River / Lake"),
        ("hill/mountain", "Hill / Mountain")
    ]

    // 10 columns for grid
    private let columns = Array(
        repeating: GridItem(
            .fixed(50),
            spacing: 0
        ),
        count: 10
    )

    var body: some View {
        VStack(spacing: 16) {

            //environment selection
            VStack(alignment: .leading, spacing: 10) {
                Text("Choose Environment")
                    .font(.headline)

                ForEach(environments, id: \.0) { environment in
                    Button {
                        selectedEnvironment = environment.0
                        generateRandomMap()
                    } label: {
                        HStack {
                            Image(
                                systemName:
                                    selectedEnvironment == environment.0
                                    ? "largecircle.fill.circle"
                                    : "circle"
                            )

                            Text(environment.1)

                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            //button to generate random map
            Button {
                generateRandomMap()
            } label: {
                Label(
                    "Generate Random Map",
                    systemImage: "map"
                )
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundStyle(.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
            }
            .padding(.horizontal)

            //map grid
            if randomMap.isEmpty {
                Spacer()

                Text("Choose an environment to generate a map.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Spacer()
            } else {
                ScrollView([.horizontal, .vertical]) {
                    LazyVGrid(
                        columns: columns,
                        spacing: 0
                    ) {
                        ForEach(
                            randomMap.indices,
                            id: \.self
                        ) { index in
                            Image(randomMap[index])
                                .resizable()
                                .interpolation(.none)
                                .frame(
                                    width: tileSize,
                                    height: tileSize
                                )
                                .clipped()
                        }
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
            }
        }
        .padding(.vertical)
        .navigationTitle("Random Map")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            generateRandomMap()
        }
    }
    
    
    private func generateRandomMap() {
        var newMap: [String] = []
        newMap.reserveCapacity(100)

        for _ in 0..<100 {
            var location = getRandomLocation()

            //selects a pseudorandom city variation
            if location == "city" {
                location = "city\(Int.random(in: 1...10))"
            }

            //select a pseudorandom grass variation
            if location == "grass" {
                location = "grass\(Int.random(in: 1...3))"
            }

            //select a pseudorandom hills variation
            if location == "hills" {
                location = "hills\(Int.random(in: 1...2))"
            }

            newMap.append(location)
        }

        randomMap = newMap
    }
    
    //case switch of ratios for different maps
    private func getRandomLocation() -> String {

        let distribution: [(String, Double)]

        switch selectedEnvironment {

        case "city":
            distribution = [
                ("city", 0.90),
                ("grass", 0.10)
            ]

        case "forest/grass":
            distribution = [
                ("grass", 0.90),
                ("mountain", 0.08),
                ("river", 0.02)
            ]

        case "river/lake":
            distribution = [
                ("grass", 0.50),
                ("river", 0.50)
            ]

        case "hill/mountain":
            distribution = [
                ("mountain", 0.60),
                ("grass", 0.30),
                ("hill", 0.10)
            ]

        default:
            return "grass"
        }

        let randomValue = Double.random(in: 0..<1)
        var cumulativeProbability = 0.0

        for (location, probability) in distribution {
            cumulativeProbability += probability

            if randomValue < cumulativeProbability {
                return location
            }
        }

        // floating point rounding
        return distribution.last?.0 ?? "grass"
    }
}


#Preview {
    NavigationStack {
        MapView()
    }
}
