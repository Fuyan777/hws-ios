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

    var spaces: [Space] { transform(from: favoriteSpaces) }

    private func transform(from favoriteSpaces: [FavoriteSpace]) -> [Space] {
        var spaceEntity: [Space] = []

        favoriteSpaces.forEach { space in
            spaceEntity.append(
                Space(id: space.spaceId,
                      name: space.spaceName,
                      description: space.spaceDescription,
                      image: space.imageUrlString,
                      address: space.address,
                      longitude: space.longitude,
                      latitude: space.latitude,
                      area: space.area,
                      equipments: EquipmentEntity().transformRealm(from: space.equipments),
                      category: CategoryEntity(category: space.category))
            )
        }
        return spaceEntity
    }
}
