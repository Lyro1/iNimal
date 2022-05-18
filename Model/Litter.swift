//
//  LitterModel.swift
//  iNimal
//
//  Created by Louis Dupont on 18/05/2022.
//

import Foundation
import SwiftUI

struct Litter {
    var id: Int
    var name: String
    var emoji: String
    var lastClean: Date
    
    public func getTimeRemaining() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour]
        let interval = Date().timeIntervalSince(lastClean)
        let timeToLive: TimeInterval = 60 * 60 * 48
        let result = formatter.string(from: timeToLive - interval)
        if ((result == nil) || interval > timeToLive) {
            return "C'est l'heure !"
        }
        return result! + "h"
    }
    
    public func getPercentage() -> CGFloat {
        let interval = Date().timeIntervalSince(lastClean)
        let timeToLive: TimeInterval = 60 * 60 * 48
        return 1 - (interval / timeToLive)
    }
    
    public func getColor() -> Color {
        let porcentage = getPercentage()
        if (porcentage > 0.5) {
            return Color.green
        }
        else if (porcentage > 0.25) {
            return Color.orange
        }
        else {
            return Color.red
        }
    }
}
