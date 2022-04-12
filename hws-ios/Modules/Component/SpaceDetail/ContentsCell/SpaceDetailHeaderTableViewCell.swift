//
//  SpaceDetailHeaderTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

class SpaceDetailHeaderTableViewCell: UITableViewCell {
    @IBOutlet var spaceImageView: UIImageView!
    @IBOutlet var spaceTitleLabel: UILabel!

    @IBOutlet var favoriteButton: UIButton! {
        didSet {
            favoriteButton.addTarget(self, action: #selector(tapFavorite), for: .touchUpInside)
        }
    }

    @IBOutlet var congestionButton: UIButton! {
        didSet {
            congestionButton.addTarget(self, action: #selector(moveGoogleMaps), for: .touchUpInside)
        }
    }

    @IBOutlet var congestionInfoButton: UIButton! {
        didSet {
            congestionInfoButton.addTarget(self, action: #selector(openAlertCongestionInfo), for: .touchUpInside)
        }
    }

    struct Component {
        enum Event {
            case moveMap, tapFavorite, moveGoogleMaps, congestionInfo
        }

        var title: String
        var address: String
        var isFavorite: Bool
        var imageUrlString: String
        var event: (Event) -> Void
        func moveMap() { event(.moveMap) }
        func moveGoogleMaps() { event(.moveGoogleMaps) }
        func tapFavorite() { event(.tapFavorite) }
        func openAlertCongestionInfo() { event(.congestionInfo) }
    }

    private var component: Component?

    func setup(component: Component) {
        self.component = component
        spaceTitleLabel.text = component.title

        component.isFavorite
            ? favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            : favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)

        spaceImageView.setImage(urlString: component.imageUrlString)
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

    @objc
    private func openAlertCongestionInfo() {
        component?.openAlertCongestionInfo()
    }
}
