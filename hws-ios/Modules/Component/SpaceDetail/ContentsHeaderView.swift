//
//  ContentsHeaderView.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/20.
//

import Foundation
import UIKit

class ContentsHeaderView: UIView, NibOwnerLoadable {
    @IBOutlet var headerTitleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }

    struct Component {
        var title: String
    }

    private var component: Component?

    func setupView(component: Component) {
        self.component = component
        headerTitleLabel.text = "◆ " + component.title
    }
}
