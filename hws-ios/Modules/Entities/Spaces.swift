//
//  Spaces.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/30.
//

import Foundation
import UIKit

struct Spaces: Codable {
    var userId: String
    var name: String
    var description: String
    var image: String
    var address: String
    var longitude: Float
    var latitude: Float
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
