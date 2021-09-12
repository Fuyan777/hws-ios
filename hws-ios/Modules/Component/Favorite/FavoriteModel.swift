//
//  FavoriteModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/07/26.
//

import Foundation

class FavoriteModel {
    var localdata = RealmManager()
    var dataCount: Int { localdata.count(type: FavoriteSpace.self) }

    var favoriteSpaces: [FavoriteSpace] {
        var tmpArray: [FavoriteSpace] = []
        localdata.findAll(type: FavoriteSpace.self).forEach {
            tmpArray.append($0)
        }
        return tmpArray
    }
}
