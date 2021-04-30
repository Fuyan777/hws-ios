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
        case cafe, beauty

        var title: String {
            switch self {
            case .cafe: return "カフェで作業"
            case .beauty: return "おしゃれな場所"
            }
        }
    }

    var tableSection = TableSection.allCases
    var spaceData = [Spaces]()
    var spacesData = [GetSpacesQuery.Data.Space]()
    let requestSuccess = PublishRelay<Void>()
    let requestError = PublishRelay<Error>()

    init() {}

    func getSpace() {
        Network.shared.apollo.fetch(query: GetSpacesQuery()) { result in
            switch result {
            case let .success(response):
                guard let spacesData = response.data?.spaces else { return }
                self.spacesData = spacesData
                self.requestSuccess.accept(())
                print(spacesData)
            case let .failure(error):
                print(error)
                self.requestError.accept(error)
            }
        }
    }
}
