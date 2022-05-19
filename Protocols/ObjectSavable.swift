//
//  ObjectSavable.swift
//  iNimal
//
//  Created by Louis Dupont on 19/05/2022.
//

import Foundation

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}
