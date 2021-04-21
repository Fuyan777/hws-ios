//
//  ContentsHeaderView.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/20.
//

import Foundation
import UIKit

class ContentsHeaderView: UIView, NibOwnerLoadable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }

    func setupView() {}
}
