//
//  SettingModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/18.
//

import UIKit

final class SettingModel {
    var tableSection = SettingContentType.allCases
}

enum SettingContentType: Int, CaseIterable {
    case app, other

    var title: String {
        switch self {
        case .app: return "アプリについて"
        case .other: return "その他"
        }
    }

    var appRows: [TableAppRow] { TableAppRow.allCases }
    var otherRows: [TableOtherRow] { TableOtherRow.allCases }

    var rowCount: Int {
        switch self {
        case .app: return appRows.count
        case .other: return otherRows.count
        }
    }

    func rowTitle(rowIndex: Int) -> String {
        switch self {
        case .app: return appRows[rowIndex].title
        case .other: return otherRows[rowIndex].title
        }
    }

    func rowIconImage(rowIndex: Int) -> UIImage? {
        switch self {
        case .app: return appRows[rowIndex].image
        case .other: return otherRows[rowIndex].image
        }
    }

    // MARK: Row

    enum TableAppRow: Int, CaseIterable {
        case request, appReview, appShare

        var title: String {
            switch self {
            case .request: return "お問い合わせ"
            case .appReview: return "アプリを評価"
            case .appShare: return "アプリをシェア"
            }
        }

        var image: UIImage? {
            switch self {
            case .request: return Asset.icArrow.image
            case .appReview: return Asset.icArrow.image
            case .appShare: return Asset.icArrow.image
            }
        }
    }

    enum TableOtherRow: Int, CaseIterable {
        case privacyPolicy, version

        var title: String {
            switch self {
            case .privacyPolicy: return "プライバシーポリシー"
            case .version: return "version \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!)(\(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")!))"
            }
        }

        var image: UIImage? {
            switch self {
            case .privacyPolicy: return Asset.icArrow.image
            case .version: return nil
            }
        }
    }
}
