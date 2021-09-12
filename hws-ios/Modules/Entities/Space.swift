//
//  Space.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/30.
//

import Foundation
import RealmSwift
import UIKit

struct Space: Codable {
    var id: String
    var name: String
    var description: String
    var image: String
    var address: String
    var longitude: Double
    var latitude: Double
    var area: String
    var equipments: [EquipmentEntity]
    var category: CategoryEntity
}

struct EquipmentEntity: Codable {
    var equipment: String = ""
}

struct CategoryEntity: Codable {
    var category = ""
}

extension EquipmentEntity {
    enum EquipmentType {
        case food, garbage, wifi, outlet, none
    }

    var equipmentType: EquipmentType {
        switch equipment {
        case "Food": return .food
        case "Garbage": return .garbage
        case "Wifi": return .wifi
        case "Outlet": return .outlet
        default: return .none
        }
    }

    func transform(to equipments: [Equipment]?) -> [EquipmentEntity] {
        var tmpArray: [EquipmentEntity] = []
        equipments?.forEach {
            tmpArray.append(EquipmentEntity(equipment: $0.rawValue))
        }
        return tmpArray
    }

    func transformRealm(from equipments: List<Equipments>) -> [EquipmentEntity] {
        var tmpArray: [EquipmentEntity] = []
        equipments.forEach {
            tmpArray.append(EquipmentEntity(equipment: $0.equipment))
        }
        return tmpArray
    }
}
