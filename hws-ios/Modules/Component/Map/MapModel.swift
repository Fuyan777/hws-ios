//
//  MapModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/24.
//

import RxRelay

final class MapModel {
    var spacesData = [GetSpacesQuery.Data.Space]()
    let requestSuccess = PublishRelay<[GetSpacesQuery.Data.Space]>()
    let requestError = PublishRelay<Error>()

    func getSpace() {
        Network.shared.apollo.fetch(query: GetSpacesQuery()) { result in
            switch result {
            case let .success(response):
                guard let spacesData = response.data?.spaces else { return }
                self.requestSuccess.accept(spacesData)
            case let .failure(error):
                self.requestError.accept(error)
            }
        }
    }
}
