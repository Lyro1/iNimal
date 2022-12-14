//
//  Data.swift
//  iNimal
//
//  Created by Louis Dupont on 19/05/2022.
//

import Foundation
import UserNotifications

private func planNotificationForLitter(litter: Litter) {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [String(litter.id)])
    
    let content = UNMutableNotificationContent()
    content.title = "Nettoyer la litièrer"
    content.subtitle = "Il est l'heure de nettoyer la litière " + litter.name + " !"
    content.sound = UNNotificationSound.default

    // show this notification five seconds from now
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 48 * 60 * 60, repeats: false)

    // choose a random identifier
    let request = UNNotificationRequest(identifier: String(litter.id), content: content, trigger: trigger)

    // add our notification request
    UNUserNotificationCenter.current().add(request)
}

func addLitter(name: String, emoji: String) {
    var litters = getAllLitters()
    let litter = Litter(id: litters.count, name: name, emoji: emoji, lastClean: Date())
    planNotificationForLitter(litter: litter)
    litters.append(litter)
    saveAllLitters(litters: litters)
}

func updateLitter(id: Int, litter: Litter) {
    var litters = getAllLitters()
    if let i = litters.firstIndex(where: { $0.id == id }) {
        if (litters[i].lastClean != litter.lastClean) {
            planNotificationForLitter(litter: litter)
        }
        litters[i] = litter
    }
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
            return littersDecoded
        } else {
            return []
        }
    } else {
        return []
    }
}

func saveAllLitters(litters: [Litter]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(litters){
        UserDefaults.standard.set(encoded, forKey: "litters")
    }
}
