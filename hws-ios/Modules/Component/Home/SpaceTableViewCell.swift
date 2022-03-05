//
//  SpaceTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2022/03/05.
//

import UIKit

class SpaceTableViewCell: UITableViewCell {
    @IBOutlet var baseView: UIView! {
        didSet {
            baseView.maskConer()
            baseView.maskShadow()
        }
    }

    @IBOutlet var spaceImageView: UIImageView! {
        didSet {
            spaceImageView.layer.cornerRadius = 4
            spaceImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }

    @IBOutlet var spaceLabel: UILabel!

    struct Component {
        var space: Space
    }

    private var component: Component?

    func setup(component: Component) {
        self.component = component
        spaceLabel.text = component.space.name
        spaceImageView.image = Asset.dammy.image
    }
}
