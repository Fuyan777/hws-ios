//
//  SpaceCollectionViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

class SpaceCollectionViewCell: UICollectionViewCell {
    @IBOutlet var spaceImageView: UIImageView! {
        didSet {
            spaceImageView.maskConer()
        }
    }

    @IBOutlet var spaceName: UILabel!

    struct Component {
        var spaceUrlString: String?
        var spaceName: String
    }

    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
        spaceName.text = component.spaceName

        guard let urlString = component.spaceUrlString else { return }
        spaceImageView.setImage(urlString: urlString)
    }
}
