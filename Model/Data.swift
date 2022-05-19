//
//  Data.swift
//  iNimal
//
//  Created by Louis Dupont on 19/05/2022.
//

import Foundation

func addLitter(name: String, emoji: String) {
    var litters = getAllLitters()
    let litter = Litter(id: litters.count, name: name, emoji: emoji, lastClean: Date())
    litters.append(litter)
    saveAllLitters(litters: litters)
}

func deleteLitter(id: Int) {
    var litters = getAllLitters()
    if let i = litters.firstIndex(where: { $0.id == id }) {
        litters.remove(at: i)
    }
    saveAllLitters(litters: litters)
}

func getAllLitters() -> [Litter] {
    if let litters = UserDefaults.standard.value(forKey: "litters") as? Data {
        let decoder = JSONDecoder()
        if let littersDecoded = try? decoder.decode(Array.self, from: litters) as [Litter] {
            print(littersDecoded)
            return littersDecoded
        } else {
            print([])
            return []
        }
    } else {
        print([])
        return []
    }
}

func saveAllLitters(litters: [Litter]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(litters){
        UserDefaults.standard.set(encoded, forKey: "litters")
    }
}
