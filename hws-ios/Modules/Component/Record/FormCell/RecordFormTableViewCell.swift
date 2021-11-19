//
//  RecordFormTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import UIKit

class RecordFormTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!

    struct Component {
        var title: String
    }

    private var component: Component?

    func configure(component: Component) {
        titleLabel.text = component.title
        datePicker.preferredDatePickerStyle = .compact
    }
}