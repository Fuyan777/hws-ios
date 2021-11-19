//
//  RecordModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import Foundation

class RecordModel {
    let cellTypes = RecordCellType.allCases
    let sectionTypes = RecordSectionType.allCases
}

enum RecordCellType: CaseIterable {
    case startDate, endDate, location, memo

    var title: String {
        switch self {
        case .startDate: return "開始"
        case .endDate: return "終了"
        case .location: return "場所"
        case .memo: return "作業メモ"
        }
    }
}

enum RecordSectionType: CaseIterable {
    case working, congestion

    var title: String {
        switch self {
        case .working: return "作業内容"
        case .congestion: return "混雑状況"
        }
    }
}
