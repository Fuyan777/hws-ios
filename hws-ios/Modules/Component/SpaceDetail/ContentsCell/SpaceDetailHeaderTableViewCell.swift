//
//  SpaceDetailHeaderTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

class SpaceDetailHeaderTableViewCell: UITableViewCell {
    @IBOutlet var spaceTitleLabel: UILabel!
    @IBOutlet var addressButton: UIButton! {
        didSet {
            addressButton.addTarget(self, action: #selector(moveMap), for: .touchUpInside)
            addressButton.setTitleColor(.gray, for: .normal)
        }
    }

    @IBOutlet var favoriteButton: UIButton! {
        didSet {
            favoriteButton.addTarget(self, action: #selector(tapFavorite), for: .touchUpInside)
        }
    }

    @IBOutlet var confusionButton: UIButton! {
        didSet {
            confusionButton.addTarget(self, action: #selector(moveGoogleMaps), for: .touchUpInside)
        }
    }

    struct Component {
        enum Event {
            case moveMap, tapFavorite, moveGoogleMaps
        }

        var title: String
        var address: String
        var isFavorite: Bool
        var event: (Event) -> Void
        func moveMap() { event(.moveMap) }
        func moveGoogleMaps() { event(.moveGoogleMaps) }
        func tapFavorite() { event(.tapFavorite) }
    }

    private var component: Component?

    func setup(component: Component) {
        self.component = component
        spaceTitleLabel.text = component.title
        addressButton.setTitle(component.address, for: .normal)

        component.isFavorite
            ? favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            : favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }

    @objc
    private func moveMap() {
        component?.moveMap()
    }

    @objc
    private func tapFavorite() {
        component?.tapFavorite()
        let isFavoriteImage = component?.isFavorite ?? false
        isFavoriteImage
            ? favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            : favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }

    @objc
    private func moveGoogleMaps() {
        component?.moveGoogleMaps()
    }
}
