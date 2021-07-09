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
    @IBOutlet var favoriteButton: UIButton! {
        didSet {
            favoriteButton.addTarget(self, action: #selector(tapFavorite), for: .touchUpInside)
        }
    }

    @IBOutlet var mapButton: UIButton! {
        didSet {
            mapButton.addTarget(self, action: #selector(moveMap), for: .touchUpInside)
        }
    }

    struct Component {
        enum Event {
            case moveMap, tapFavorite
        }

        var title: String
        var address: String
        var event: (Event) -> Void
        func moveMap() { event(.moveMap) }
        func tapFavorite() { event(.tapFavorite) }
    }

    private var component: Component?

    func setup(component: Component) {
        self.component = component
        spaceTitleLabel.text = component.title
        spaceAddressLabel.text = component.address
    }

    @objc
    private func moveMap() {
        component?.moveMap()
    }

    @objc
    private func tapFavorite() {
        // TODO: サーバーできたら実装
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        component?.tapFavorite()
    }
}
