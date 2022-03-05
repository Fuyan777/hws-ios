//
//  RecordModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import Foundation
import RxRelay
import RxSwift

class RecordModel {
    let requestSuccess = PublishRelay<Void>()
    let requestError = PublishRelay<Error>()

    let cellTypes = RecordCellType.allCases
    private var realmManager = RealmManager()
    private var recordItem = RecordItems()
    var spacesNameArray: [String] = []

    func addRecordItems() {
        let item = RecordItems()
        item.recordId = UUID().uuidString
        item.startDate = recordItem.startDate
        item.endDate = recordItem.endDate
        item.congestionName = recordItem.congestionName
        item.locationName = recordItem.locationName
        item.memo = recordItem.memo
        realmManager.add(object: item)
    }

    func update(startDate: Date) {
        recordItem.startDate = startDate
    }

    func update(endDate: Date) {
        recordItem.endDate = endDate
    }

    func update(congestionName: String) {
        recordItem.congestionName = congestionName
    }

    func update(locationName: String) {
        recordItem.locationName = locationName
    }

    func update(memo: String) {
        recordItem.memo = memo
    }

    func getSpaceName() {
        Network.shared.apollo.fetch(query: GetSpacesQuery()) { result in
            switch result {
            case let .success(response):
                guard let spacesData = response.data?.spaces else { return }
                self.spacesNameArray = self.transform(from: spacesData)
                self.requestSuccess.accept(())
            case let .failure(error):
                self.requestError.accept(error)
            }
        }
    }

    private func transform(from spaces: [GetSpacesQuery.Data.Space]) -> [String] {
        var spaceName: [String] = []
        spaces.forEach { space in
            spaceName.append(space.name)
        }
        return spaceName
    }
}

enum RecordCellType: CaseIterable {
    case startDate, endDate, location, congestion, memo

    var title: String {
        switch self {
        case .startDate: return "開始"
        case .endDate: return "終了"
        case .location: return "場所"
        case .congestion: return "混雑状況"
        case .memo: return "作業メモ"
        }
    }
}
