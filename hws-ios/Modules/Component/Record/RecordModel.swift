//
//  RecordModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import Foundation

class RecordModel {
    let cellTypes = RecordCellType.allCases
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
