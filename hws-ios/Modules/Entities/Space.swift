//
//  Space.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/30.
//

import Foundation
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
    var equipments: [Equipment]
    var category: [Category]

    struct Equipment: Codable {
        var equipment: String = ""
    }

    struct Category: Codable {
        var category = ""
    }
}
