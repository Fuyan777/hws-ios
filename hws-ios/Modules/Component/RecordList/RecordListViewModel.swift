//
//  RecordListViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/06.
//

import Foundation
import RxRelay
import RxSwift
import UIKit

class RecordListViewModel: NSObject {
    struct Dependency {
        let router: RecordRouting

        static func `default`(router: RecordRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    let barButtonItem = PublishRelay<UIBarButtonItem>()
    let deleteIndexPath = PublishRelay<IndexPath>()
    let reloadData = PublishRelay<Void>()

    private let model: RecordListModel
    private let dependency: Dependency

    init(model: RecordListModel, dependency: Dependency) {
        self.model = model
        self.dependency = dependency
        super.init()
    }

    func setBarButtonItem() {
        let rightButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        rightButton.tintColor = Asset.accentColor.color
        barButtonItem.accept(rightButton)
    }

    @objc
    func addButtonTapped() {
        dependency.router.presentRecord(delegate: self)
    }
}

extension RecordListViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return model.recordItems.count == 0 ? 1 : 0
        case 1:
            return model.recordItems.count != 0 ? model.recordItems.count : 0
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath) as EmptyTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordListTableViewCell
            let component = RecordListTableViewCell.Component(
                title: model.recordItems[indexPath.row].locationName,
                date: model.startDate[indexPath.row],
                imageType: model.convertStringToImageType(congestionName: model.recordItems[indexPath.row].congestionName)
            )
            cell.configure(component: component)
            return cell
        default: return UITableViewCell()
        }
    }
}

extension RecordListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            guard editingStyle == .delete else { return }

            model.delete(index: indexPath.row)
            deleteIndexPath.accept(indexPath)
        default: break
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        indexPath.section == 1 ? .delete : .none
    }
}

extension RecordListViewModel: RecordListUpdateDelegate {
    func updateList() {
        reloadData.accept(())
    }
}
