//
//  LitterModel.swift
//  iNimal
//
//  Created by Louis Dupont on 18/05/2022.
//

import Foundation
import SwiftUI

struct Litter: ObjectSavable, Encodable, Decodable {
    var id: Int
    var name: String
    var emoji: String
    var lastClean: Date
    var offset: CGFloat = 0
    
    public func getTimeRemaining() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour]
        let interval = Date().timeIntervalSince(lastClean)
        let timeToLive: TimeInterval = 48 * 60 * 60
        let result = formatter.string(from: timeToLive - interval)
        if ((result == nil) || interval > timeToLive) {
            return "⌛️"
        }
        if (result == "0") {
            return "<1h"
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
    
    public func clean() -> Void {
        var litterToUpdate = self
        litterToUpdate.lastClean = Date()
        updateLitter(id: self.id, litter: litterToUpdate)
    }
    
    public func serialize()throws -> Data {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    public func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            defaults.set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    public func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}
