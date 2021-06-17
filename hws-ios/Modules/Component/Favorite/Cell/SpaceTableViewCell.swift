//
//  SpaceTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/11.
//

import UIKit

class SpaceTableViewCell: UITableViewCell {
    @IBOutlet var spaceImageView: UIImageView!
    @IBOutlet var spaceTitle: UILabel!

    struct Component {
        var imageUrlString: String
        var title: String
    }

    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
        spaceTitle.text = component.title
        //        spaceImageView.setImage(urlString: component.imageUrlString)
    }
}
