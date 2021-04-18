//
//  ContentIconCollectionViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/19.
//

import UIKit

class ContentIconCollectionViewCell: UICollectionViewCell {
    struct Component {}

    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
    }
}
