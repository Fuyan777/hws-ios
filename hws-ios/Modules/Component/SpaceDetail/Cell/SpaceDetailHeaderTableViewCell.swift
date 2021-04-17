//
//  SpaceDetailHeaderTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

class SpaceDetailHeaderTableViewCell: UITableViewCell {
    struct Component {}

    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
    }
}
