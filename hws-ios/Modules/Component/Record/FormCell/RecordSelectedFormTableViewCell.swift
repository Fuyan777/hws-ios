//
//  RecordSelectedFormTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import UIKit

class RecordSelectedFormTableViewCell: UITableViewCell {
    @IBOutlet var congestionButton: UIButton!
    @IBOutlet var normalButton: UIButton!
    @IBOutlet var comfortableButton: UIButton!

    struct Component {}

    private var component: Component?

    func configure(component: Component) {
        self.component = component
        congestionButton.setTitle("", for: .normal)
        congestionButton.setImage(Asset.icCongestion.image, for: .normal)

        normalButton.setTitle("", for: .normal)
        normalButton.setImage(Asset.icNormal.image, for: .normal)

        comfortableButton.setTitle("", for: .normal)
        comfortableButton.setImage(Asset.icComfortable.image, for: .normal)
    }
}
