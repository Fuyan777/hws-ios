//
//  RecordViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import Foundation
import RxRelay
import UIKit

final class RecordViewModel: NSObject {
    struct Dependency {
        let router: RecordRouting

        static func `default`(router: RecordRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    private let model: RecordModel
    private let dependency: Dependency

    let didTapDoneButton = PublishRelay<Void>()
    let didTapCancelButton = PublishRelay<Void>()
    let barButtonItem = PublishRelay<UIBarButtonItem>()

    init(model: RecordModel, dependency: Dependency) {
        self.model = model
        self.dependency = dependency
    }

    func setBarButtonItem() {
        let rightButton = UIBarButtonItem(
            title: "追加",
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        rightButton.tintColor = Asset.accentColor.color
        barButtonItem.accept(rightButton)
    }

    @objc
    func addButtonTapped() {
        model.addRecordItems()
        dependency.router.pop()
    }
}

extension RecordViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.cellTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch model.cellTypes[indexPath.row] {
        case .startDate:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordFormTableViewCell
            let component = RecordFormTableViewCell.Component(title: model.cellTypes[indexPath.row].title) { event in
                switch event {
                case let .selectedDate(date):
                    self.model.update(startDate: date)
                }
            }
            cell.configure(component: component)
            return cell
        case .endDate:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordFormTableViewCell
            let component = RecordFormTableViewCell.Component(title: model.cellTypes[indexPath.row].title) { event in
                switch event {
                case let .selectedDate(date):
                    self.model.update(endDate: date)
                }
            }
            cell.configure(component: component)
            return cell
        case .location:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordPickerFormTableViewCell
            let component = RecordPickerFormTableViewCell.Component(
                title: model.cellTypes[indexPath.row].title,
                list: ["該当なし", "orange", "mouth", "america"], viewWidth: 300
            ) { event in
                switch event {
                case let .doneTapped(selectedItems):
                    self.model.update(locationName: selectedItems)
                    self.didTapDoneButton.accept(())
                case .cancelTapped:
                    self.didTapCancelButton.accept(())
                }
            }
            cell.configure(component: component)
            return cell
        case .congestion:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordPickerFormTableViewCell
            let component = RecordPickerFormTableViewCell.Component(
                title: model.cellTypes[indexPath.row].title,
                list: ["快適", "普通", "混雑"],
                viewWidth: 300
            ) { event in
                switch event {
                case let .doneTapped(selectedItems):
                    self.model.update(congestionName: selectedItems)
                    self.didTapDoneButton.accept(())
                case .cancelTapped:
                    self.didTapCancelButton.accept(())
                }
            }
            cell.configure(component: component)
            return cell
        case .memo:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordTextViewFormTableViewCell
            let component = RecordTextViewFormTableViewCell.Component(memoText: model.cellTypes[indexPath.row].title) { event in
                switch event {
                case let .doneTapped(text):
                    self.model.update(memo: text)
                    self.didTapDoneButton.accept(())
                }
            }
            cell.configure(component: component)
            return cell
        }
    }
}

extension RecordViewModel: UITableViewDelegate {}
