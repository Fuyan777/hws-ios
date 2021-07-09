//
//  SpaceDetailViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

class SpaceDetailViewModel: NSObject {
    struct Dependency {
        var router: SpaceDetailRouting

        static func `default`(router: SpaceDetailRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    private let dependency: Dependency
    let model: SpaceDetailModel
    let tableSection: [TableSection] = TableSection.allCases

    init(model: SpaceDetailModel, dependency: Dependency) {
        self.model = model
        self.dependency = dependency
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
            let component = SpaceDetailHeaderTableViewCell.Component(
                title: model.spaceDetail.name,
                address: model.spaceDetail.address ?? "住所不明"
            ) { event in
                switch event {
                case .moveMap:
                    self.dependency.router.pushMap()
                }
            }
            cell.setup(component: component)
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContentsTextViewTableViewCell
            let component = ContentsTextViewTableViewCell.Component(
                text: model.spaceDetail.description ?? "説明なし"
            )
            cell.setupCell(component: component)
            return cell
        case .equipment:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContentsIconTableViewCell
            guard let equipment = model.equipments else { return cell }
            let component = ContentsIconTableViewCell.Component(
                equipment: equipment
            )
            cell.setupCell(component: component)
            return cell
        case .attension:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContentsTextViewTableViewCell
            let component = ContentsTextViewTableViewCell.Component(
                text: "基本的に静かに作業するようにしましょう！！"
            )
            cell.setupCell(component: component)
            return cell
        }
    }
}
