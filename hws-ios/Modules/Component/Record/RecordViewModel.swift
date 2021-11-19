//
//  RecordViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import Foundation
import UIKit

final class RecordViewModel: NSObject {
    private let model: RecordModel

    init(model: RecordModel) {
        self.model = model
    }
}

extension RecordViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        model.sectionTypes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch model.sectionTypes[section] {
        case .working: return model.cellTypes.count
        case .congestion: return 1
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        model.sectionTypes[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch model.sectionTypes[indexPath.section] {
        case .working:

            switch model.cellTypes[indexPath.row] {
            case .startDate, .endDate:
                let cell = tableView.dequeueReusableCell(for: indexPath) as RecordFormTableViewCell
                let component = RecordFormTableViewCell.Component(title: model.cellTypes[indexPath.row].title)
                cell.configure(component: component)
                return cell
            case .location:
                let cell = tableView.dequeueReusableCell(for: indexPath) as RecordPickerFormTableViewCell
                let component = RecordPickerFormTableViewCell.Component()
                cell.configure(component: component)
                return cell
            case .memo:
                let cell = tableView.dequeueReusableCell(for: indexPath) as RecordTextViewFormTableViewCell
                let component = RecordTextViewFormTableViewCell.Component(memoText: model.cellTypes[indexPath.row].title)
                cell.configure(component: component)
                return cell
            }

        case .congestion:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordSelectedFormTableViewCell
            let component = RecordSelectedFormTableViewCell.Component()
            cell.configure(component: component)
            return cell
        }
    }
}

extension RecordViewModel: UITableViewDelegate {}
