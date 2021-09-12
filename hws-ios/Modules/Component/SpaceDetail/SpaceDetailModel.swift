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
    var spacesDetail: GetSpacesQuery.Data.Space?
    var favoriteSpaceDetail: FavoriteSpace?
    var isFavorite: Bool = true
    var isFavoriteVC: Bool
    var equipments: [Equipment]? {
        spacesDetail?.equipments
    }

    let reloadData = PublishRelay<Void>()
    let requestError = PublishRelay<Error>()

    // 通常画面から遷移した場合
    init(spacesDetail: GetSpacesQuery.Data.Space) {
        self.spacesDetail = spacesDetail
        isFavorite = realmManager.findFavoriteSpace(spaceId: spacesDetail.id)
        isFavoriteVC = false
    }

    // お気に入り画面から遷移した場合
    init(favoriteSpaceDetail: FavoriteSpace) {
        self.favoriteSpaceDetail = favoriteSpaceDetail
        isFavoriteVC = true
    }

    func addFavorite() {
        guard let spaceDetail = spacesDetail else { return }
        isFavorite.toggle()

        let space = FavoriteSpace()
        space.spaceId = spaceDetail.id
        space.spaceName = spaceDetail.name
        space.spaceDescription = spaceDetail.description ?? ""
        space.address = spaceDetail.address ?? ""
        space.longitude = spaceDetail.longitude ?? 0.0
        space.latitude = spaceDetail.latitude ?? 0.0
        space.area = spaceDetail.area?.rawValue ?? ""
        space.category = spaceDetail.category?.rawValue ?? ""
        spaceDetail.equipments?.forEach {
            let equipments = Equipments()
            equipments.equipment = $0.rawValue
            space.equipments.append(equipments)
        }
        realmManager.add(object: space)
        reloadData.accept(())
    }

    func deleteFavorite() {
        guard let spaceDetail = spacesDetail else { return }
        isFavorite.toggle()
        realmManager.deleteFavoriteSpace(spaceId: spaceDetail.id)
        reloadData.accept(())
    }
}
