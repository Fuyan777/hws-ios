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
    let requestSuccess = PublishRelay<GetSpaceQuery.Data.Space>()
    let requestError = PublishRelay<Error>()

    init() {}

    func getSpace() {
        Network.shared.apollo.fetch(query: GetSpaceQuery()) { result in
            switch result {
            case let .success(response):
                guard let response = response.data?.space else { return }
                self.requestSuccess.accept(response)
            case let .failure(error):
                print(error)
                self.requestError.accept(error)
            }
        }
    }
}
