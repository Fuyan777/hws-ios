//
//  SpaceDetailContents.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/18.
//

import Foundation

struct SpaceDetailContents {
    var description: String
    var equipment: [EquipmentItem]?
    var attension: String
}

struct EquipmentItem {
    var wifi: String?
    var food: String?
    var outlet: String?
}
