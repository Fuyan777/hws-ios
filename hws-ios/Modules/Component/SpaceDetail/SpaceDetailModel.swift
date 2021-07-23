//
//  SpaceDetailModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/17.
//

import RxRelay

class SpaceDetailModel {
    var spaceDetail: GetSpacesQuery.Data.Space
    var equipments: [Equipment]? { spaceDetail.equipments }
    private var realmManager = RealmManager()
    var isFavorite: Bool
    var reloadData = PublishRelay<Void>()

    init(spaceDetail: GetSpacesQuery.Data.Space) {
        self.spaceDetail = spaceDetail
        isFavorite = realmManager.findFavoriteSpace(spaceId: spaceDetail.id)
    }

    func addFavorite() {
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
        isFavorite.toggle()
        realmManager.deleteFavoriteSpace(spaceId: spaceDetail.id)
        reloadData.accept(())
    }
}
