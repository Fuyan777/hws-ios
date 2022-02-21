//
//  RecordModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import Foundation

class RecordModel {
    let cellTypes = RecordCellType.allCases
    private var realmManager = RealmManager()
    private var recordItem = RecordItems()

    func addRecordItems() {
        let item = RecordItems()
        item.recordId = "1"
        item.startDate = recordItem.startDate
        item.endDate = recordItem.endDate
        item.congestionName = recordItem.congestionName
        item.locationName = recordItem.locationName
        item.memo = recordItem.memo
        realmManager.add(object: item)
    }

    func update(startDate: String) {
        recordItem.startDate = startDate
    }

    func update(endDate: String) {
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
