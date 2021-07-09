//
//  SpaceDetailViewModel+TableView.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/20.
//

import UIKit

extension SpaceDetailViewModel {
    enum TableSection: Int, CaseIterable {
        case header, description, equipment, attension

        var title: String {
            switch self {
            case .description: return "スペースの説明"
            case .equipment: return "設備"
            case .attension: return "利用上の注意"
            default: return ""
            }
        }
    }

    // TODO: 0か1にするかの制御を追加
    func tableRowCount(section: Int) -> Int {
        switch tableSection[section] {
        case .header: return 1
        case .description: return 1
        case .equipment: return model.equipments == nil ? 0 : 1
        case .attension: return 1
        }
    }

    func tableHeightForHeader(section: Int) -> CGFloat {
        switch tableSection[section] {
        case .header: return 0
        default: return 60
        }
    }

    func viewForHeader(section: Int, view: UIView) -> UIView? {
        switch tableSection[section] {
        case .header: return nil
        default:
            let headerView = ContentsHeaderView()
            let component = ContentsHeaderView.Component(title: tableSection[section].title)
            headerView.setupView(component: component)
            return headerView
        }
    }
}
