//
//  RecordListTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/06.
//

import UIKit

class RecordListTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var congestionImageView: UIImageView!

    struct Component {
        var title: String
        var date: String
        var imageType: ImageType
    }

    private var component: Component?

    func configure(component: Component) {
        self.component = component
        titleLabel.text = component.title
        dateLabel.text = "作業日：" + component.date
        congestionImageView.image = component.imageType.image
    }
}

enum ImageType {
    case comfortable, normal, congestion

    var image: UIImage {
        switch self {
        case .comfortable:
            return Asset.icComfortable.image
        case .normal:
            return Asset.icNormal.image
        case .congestion:
            return Asset.icCongestion.image
        }
    }
}
