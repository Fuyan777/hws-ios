//
//  SpaceDetailModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/17.
//

import Foundation
import RxRelay

class SpaceDetailModel {
    private var realmManager = RealmManager()
    var spacesDetail: Space
    var favoriteSpaceDetail: FavoriteSpace?
    var isFavorite: Bool = true
    var isFavoriteVC: Bool
    var equipments: [EquipmentEntity] {
        spacesDetail.equipments
    }

    let reloadData = PublishRelay<Void>()
    let requestError = PublishRelay<Error>()

    // 通常画面から遷移した場合
    init(spacesDetail: Space) {
        self.spacesDetail = spacesDetail
        isFavorite = realmManager.findFavoriteSpace(spaceId: spacesDetail.id)
        isFavoriteVC = false
    }

    // お気に入り画面から遷移した場合
    init(favoriteSpaceDetail: FavoriteSpace) {
        spacesDetail = Space(id: "", name: "", description: "", image: "", address: "", longitude: 0.0, latitude: 0.0, area: "", equipments: [EquipmentEntity](), category: CategoryEntity())
        self.favoriteSpaceDetail = favoriteSpaceDetail
        isFavoriteVC = true
    }

    func addFavorite() {
        isFavorite.toggle()

        let space = FavoriteSpace()
        space.spaceId = spacesDetail.id
        space.spaceName = spacesDetail.name
        space.spaceDescription = spacesDetail.description
        space.imageUrlString = spacesDetail.image
        space.address = spacesDetail.address
        space.longitude = spacesDetail.longitude
        space.latitude = spacesDetail.latitude
        space.area = spacesDetail.area
        space.category = spacesDetail.category.category
        spacesDetail.equipments.forEach {
            let equipments = Equipments()
            equipments.equipment = $0.equipment
            space.equipments.append(equipments)
        }
        realmManager.add(object: space)
        reloadData.accept(())
    }

    func deleteFavorite() {
        isFavorite.toggle()
        realmManager.deleteFavoriteSpace(spaceId: spacesDetail.id)
        reloadData.accept(())
    }
}
