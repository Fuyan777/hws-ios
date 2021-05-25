//
//  SpaceDetailHeaderTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

class SpaceDetailHeaderTableViewCell: UITableViewCell {
    @IBOutlet var spaceTitleLabel: UILabel!
    @IBOutlet var spaceAddressLabel: UILabel!

    struct Component {
        var title: String
        var address: String
    }

    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
        spaceTitleLabel.text = component.title
        spaceAddressLabel.text = component.address
    }
}
