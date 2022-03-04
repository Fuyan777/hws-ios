//
//  RecordListModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2022/02/20.
//

import Foundation
import RxRelay
import RxSwift

class RecordListModel {
    let recordItem = BehaviorRelay<[RecordItems]>(value: [])
    var localdata = RealmManager()
    var recordItems: [RecordItems] {
        var tmpArray: [RecordItems] = []
        localdata.findAll(type: RecordItems.self).forEach {
            tmpArray.append($0)
        }
        return tmpArray
    }

    var startDate: [String] {
        convertStartDateToString()
    }

    var endDate: [String] {
        convertEndDateToString()
    }

    init() {}

    private func convertStartDateToString() -> [String] {
        var tmpArray: [String] = []
        let dateFormatter = DateFormatter()

        recordItems.forEach {
            dateFormatter.dateFormat = "yyyy'年'M'月'd'日"
            let str = dateFormatter.string(from: $0.startDate)
            tmpArray.append(str)
        }
        return tmpArray
    }

    private func convertEndDateToString() -> [String] {
        var tmpArray: [String] = []
        let dateFormatter = DateFormatter()

        recordItems.forEach {
            dateFormatter.dateFormat = "yyyy'年'M'月'd'日"
            let str = dateFormatter.string(from: $0.endDate)
            tmpArray.append(str)
        }
        return tmpArray
    }

    func convertStringToImageType(congestionName: String) -> ImageType {
        switch congestionName {
        case "混雑":
            return .congestion
        case "普通":
            return .normal
        case "快適":
            return .comfortable
        default: return .normal
        }
    }

    func delete(index: Int) {
        localdata.delete(recordId: recordItems[index].recordId)
    }
}
