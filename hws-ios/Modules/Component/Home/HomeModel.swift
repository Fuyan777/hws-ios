//
//  HomeModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import Foundation
import RxRelay
import RxSwift

final class HomeModel {
    enum TableSection: Int, CaseIterable {
        case area, cafe, beauty

        var title: String {
            switch self {
            case .area: return "エリアで選択"
            case .cafe: return "カフェで選択"
            case .beauty: return "Wi-Fiのあるスペースで選択"
            }
        }
    }

    var tableSection = TableSection.allCases
    var spacesData = [Space]()
    let requestSuccess = PublishRelay<Void>()
    let requestError = PublishRelay<Error>()

    func getSpace() {
        Network.shared.apollo.fetch(query: GetSpacesQuery()) { result in
            switch result {
            case let .success(response):
                guard let spacesData = response.data?.spaces else { return }
                self.spacesData = self.transform(from: spacesData)
                self.requestSuccess.accept(())
            case let .failure(error):
                self.requestError.accept(error)
            }
        }
    }

    func transform(from spaces: [GetSpacesQuery.Data.Space]) -> [Space] {
        var spaceEntity: [Space] = []

        spaces.forEach { space in
            spaceEntity.append(
                Space(id: space.id,
                      name: space.name,
                      description: space.description ?? "",
                      image: space.image ?? "",
                      address: space.address ?? "",
                      longitude: space.longitude ?? 0.0,
                      latitude: space.latitude ?? 0.0,
                      area: space.area?.rawValue ?? "",
                      equipments: EquipmentEntity().transform(to: space.equipments),
                      category: CategoryEntity(category: space.category?.rawValue ?? ""))
            )
        }
        return spaceEntity
    }
}
