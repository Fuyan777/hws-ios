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
    private let model: RecordModel

    let didTapDoneButton = PublishRelay<Void>()
    let didTapCancelButton = PublishRelay<Void>()

    init(model: RecordModel) {
        self.model = model
    }
}

extension RecordViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.cellTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch model.cellTypes[indexPath.row] {
        case .startDate, .endDate:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordFormTableViewCell
            let component = RecordFormTableViewCell.Component(title: model.cellTypes[indexPath.row].title)
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
                case .doneTapped:
                    self.didTapDoneButton.accept(())
                }
            }
            cell.configure(component: component)
            return cell
        }
    }
}

extension RecordViewModel: UITableViewDelegate {}
