//
//  SettingTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/18.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!

    struct Component {
        var title: String
    }

    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
    }
}
