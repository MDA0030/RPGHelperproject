//
//  NPC.swift
//
//
//  Created by matt on 10/26/26.
//


import SwiftUI

//struct for data values that makeup a NPC
struct NPCValues {
    var chaoticLaw = ""
    var race = ""
    var age = ""
    var playerClass = ""
    var hp = 0
    var homeTown = ""
    var basicGear = ""
    var weapon = ""
    var extraGear = ""
    var level = 1
    var imageName: String? = nil
}


//generates the NPC
struct NPCGenerator {

    private struct ClassOption {
        let name: String
        let hp: Int
    }

    private static func randomValue<T>(from options: [T]) -> T {
        options.randomElement()!
    }

    //values of the extra data that makesup NPC
    static func generateNPC() -> NPCValues {

        let chaoticLawOptions = [
            "Chaotic Good", "Chaotic Neutral", "Chaotic Evil",
            "True Neutral", "Lawful Good", "Lawful Evil"
        ]

        let raceOptions = [
            "Deep Dwarf", "Hills Dwarf", "Human", "Gnome",
            "High Elf", "Moon Elf", "Wild Elf", "Drow"
        ]

        let ageOptions = [
            "Adult", "Middle aged", "Elderly"
        ]

        let playerClassOptions = [
            ClassOption(name: "Bard", hp: 8),
            ClassOption(name: "Fighter", hp: 10),
            ClassOption(name: "Barbarian", hp: 12),
            ClassOption(name: "Ranger", hp: 10),
            ClassOption(name: "Monk", hp: 8),
            ClassOption(name: "Ninja", hp: 8),
            ClassOption(name: "Rogue", hp: 8),
            ClassOption(name: "Cleric", hp: 8),
            ClassOption(name: "Psionicist", hp: 8),
            ClassOption(name: "Wizard", hp: 6),
            ClassOption(name: "Sorcerer", hp: 6),
            ClassOption(name: "Druid", hp: 8),
            ClassOption(name: "Artificer", hp: 8),
            ClassOption(name: "Paladin", hp: 10)
        ]

        let gearOptions = [
            "Hammer", "Old bucket", "Lock pick set",
            "Fruit", "Bread", "Compass"
        ]

        let hometownOptions = [
            "Anusis", "Teakwood Village", "Wavestead Port",
            "Iron town", "Lost Creek", "Eulus Mountain"
        ]

        let weaponOptions = [
            "Dagger", "Axe", "Mace",
            "Long sword", "Short sword", "Staff"
        ]

        let extraGearOptions = [
            "Big dog", "Small dog", "Cat", "Pony",
            "Horse", "Pet bird", "Hamster", "None"
        ]

        // get the NPC's basic attributes class, race and level
        let selectedClass = randomValue(from: playerClassOptions)

        let race = randomValue(from: raceOptions)
        let level = Int.random(in: 1...20)

        // random hit points for NPC
        let hpRoll = Int.random(in: 0..<selectedClass.hp)
        let hp = ((hpRoll * level + 1) * 4) / 2

        let extraGear = selectedClass.name == "Paladin"
            ? "War horse"
            : randomValue(from: extraGearOptions)

        // images for the NPC
        let imageSources: [String: [String]] = [
            "human": [
                "human1", "humanF1", "human2",
                "human4", "human6"
            ],
            "elf": [
                "elf1", "elf2", "elf3", "elf4", "elf5"
            ],
            "dwarf": [
                "dwarf1", "dwarf2"
            ],
            "drow": [
                "drow1", "drow2", "drow3", "drow4",
                "drow5", "drow6", "drow7"
            ]
        ]

        let imageType: String?

        // case switch for NPC race
        switch race {
        case "Human":
            imageType = "human"

        case "High Elf", "Moon Elf", "Wild Elf":
            imageType = "elf"

        case "Deep Dwarf", "Hills Dwarf":
            imageType = "dwarf"

        case "Drow":
            imageType = "drow"

        default:
            imageType = nil
        }

        let imageName = imageType.flatMap {
            imageSources[$0]?.randomElement()
        }

        // returns data values of the NPC
        return NPCValues(
            chaoticLaw: randomValue(from: chaoticLawOptions),
            race: race,
            age: randomValue(from: ageOptions),
            playerClass: selectedClass.name,
            hp: hp,
            homeTown: randomValue(from: hometownOptions),
            basicGear: randomValue(from: gearOptions),
            weapon: randomValue(from: weaponOptions),
            extraGear: extraGear,
            level: level,
            imageName: imageName
        )
    }
}


struct NPCView: View {

    @State private var npc: NPCValues? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                Text("NPC Generator")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // button to generate random NPC
                Button {
                    npc = NPCGenerator.generateNPC()
                } label: {
                    Text("Generate NPC")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )
                }

                if let npc = npc {

                    // NPC Image (pseudo random)
                    if let imageName = npc.imageName {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                maxWidth: 260,
                                maxHeight: 260
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12)
                            )
                    } else {
                        Image(systemName: "person.crop.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundStyle(.secondary)
                    }

                    // NPC Attributes
                    Group {
                        npcLabel("Alignment", npc.chaoticLaw)
                        npcLabel("Race", npc.race)
                        npcLabel("Age", npc.age)
                        npcLabel("Player Class", npc.playerClass)
                        npcLabel("Hit Points", "\(npc.hp)")
                        npcLabel("Level", "\(npc.level)")
                        npcLabel("Home Town", npc.homeTown)
                        npcLabel("Basic Gear", npc.basicGear)
                        npcLabel("Weapon", npc.weapon)
                        npcLabel("Extra Gear", npc.extraGear)
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )

                } else {
                    Text("Tap Generate NPC to create a character.")
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 20)
                }
            }
            .padding()
        }
        .navigationTitle("NPC")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    //label for NPC
    private func npcLabel(
        _ title: String,
        _ value: String
    ) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text("\(title):")
                .fontWeight(.semibold)

            Text(value)
        }
        .font(.body)
    }
}


#Preview {
    NavigationStack {
        NPCView()
    }
}
