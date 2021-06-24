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
    @IBOutlet var mapButton: UIButton! {
        didSet {
            mapButton.addTarget(self, action: #selector(moveMap), for: .touchUpInside)
        }
    }

    struct Component {
        enum Event {
            case moveMap
        }

        var title: String
        var address: String
        var event: (Event) -> Void
        func moveMap() { event(.moveMap) }
    }

    private var component: Component?

    func setup(component: Component) {
        self.component = component
        spaceTitleLabel.text = component.title
        spaceAddressLabel.text = component.address
    }

    @objc func moveMap() {
        component?.moveMap()
    }
}
