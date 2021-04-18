//
//  SpaceDetailViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

class SpaceDetailViewModel: NSObject {
    private let model: SpaceDetailModel
    let tableSection: [TableSection] = TableSection.allCases
    let contentsList: [ContentsList] = ContentsList.allCases

    init(model: SpaceDetailModel) {
        self.model = model
    }
}

extension SpaceDetailViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableRowCount(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableSection[indexPath.section] {
        case .header:
            let cell = tableView.dequeueReusableCell(for: indexPath) as SpaceDetailHeaderTableViewCell
            let component = SpaceDetailHeaderTableViewCell.Component()
            cell.setupCell(component: component)
            return cell
        case .contents:
            let cell = tableView.dequeueReusableCell(for: indexPath) as SpaceDetailContentsTableViewCell
            cell.setupCell(component: contentsList[indexPath.row].component)
            return cell
        }
    }

    enum TableSection: Int, CaseIterable {
        case header, contents
    }

    func tableRowCount(section: Int) -> Int {
        switch tableSection[section] {
        case .header: return 1
        case .contents: return contentsList.count
        }
    }

    //    func tableRowCount(section: Int) -> Int {
    //        switch tableSection[section] {
    //        case .header: return 1
    //        case .contents:
    //            switch contentsList[section] {
    //            case .description:
    //                return 1
    //            case .equipment:
    //                return 1
    //            case .attension:
    //                return 1
    //            }
    //        }
    //    }

    enum ContentsList: Int, CaseIterable {
        case description, equipment, attension

        var component: SpaceDetailContentsTableViewCell.Component {
            switch self {
            case .description:
                return SpaceDetailContentsTableViewCell.Component(contentName: "◆ スペースの詳細", contentzType: .spaceDescription)
            case .equipment:
                return SpaceDetailContentsTableViewCell.Component(contentName: "◆ 設備", contentzType: .equipment)
            case .attension:
                return SpaceDetailContentsTableViewCell.Component(contentName: "◆ 注意事項", contentzType: .attension)
            }
        }
    }
}
