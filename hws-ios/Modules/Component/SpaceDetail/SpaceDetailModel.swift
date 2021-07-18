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
        space.spaceId = "hakodate-gsquare-id"
        space.spaceName = "fuya"
        space.spaceDescription = "こんにちは、今日は良い天気ダオ"
        realmManager.add(object: space)

        // TODO: 確認用
        print("-----add------")
        let value = realmManager.findAll(type: FavoriteSpace.self)
        value.forEach { res in
            print(res.spaceId)
        }
        print("--------------")
        reloadData.accept(())
    }

    func deleteFavorite() {
        isFavorite.toggle()
        realmManager.deleteFavoriteSpace(spaceId: spaceDetail.id)

        // TODO: 確認用
        print("-----delete------")
        let value = realmManager.findAll(type: FavoriteSpace.self)
        value.forEach { res in
            print(res.spaceId)
        }
        print("--------------")
        reloadData.accept(())
    }
}
