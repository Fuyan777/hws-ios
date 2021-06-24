//
//  SettingTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/18.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    struct Component {
        var title: String
        var iconImage: UIImage?
    }

    private var component: Component?

    func setup(component: Component) {
        self.component = component
        titleLabel.text = component.title

        guard let iconImage = component.iconImage else { return }
        iconImageView.image = iconImage
    }
}
