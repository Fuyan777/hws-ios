//
//  ContentIconCollectionViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/19.
//

import UIKit

class ContentIconCollectionViewCell: UICollectionViewCell {
    @IBOutlet var iconImageView: UIImageView!

    struct Component {
        var equipment: EquipmentEntity
    }

    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
        selectedIcon()
    }

    private func selectedIcon() {
        let elementType = component?.equipment.equipmentType

        switch elementType {
        case .food:
            iconImageView.image = Asset.icFood.image
        case .garbage:
            iconImageView.image = Asset.icGarbage.image
        case .wifi:
            iconImageView.image = Asset.icWifi.image
        case .outlet:
            iconImageView.image = Asset.icOutlet.image
        default: break
        }
    }
}
