//
//  FavoriteSpaceContentIconCollectionViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/08/07.
//

import UIKit

class FavoriteSpaceContentIconCollectionViewCell: UICollectionViewCell {
    @IBOutlet var iconImageView: UIImageView!

    struct ComponentFavorite {
        var equipment: EquipmentEntity
    }

    private var componentFavorite: ComponentFavorite?

    func setupCell(component: ComponentFavorite) {
        componentFavorite = component
        selectedIconFavorite()
    }

    private func selectedIconFavorite() {
        guard let equipment = componentFavorite?.equipment else { return }
        let value = Equipment(rawValue: equipment.equipment)
        switch value {
        case .food:
            iconImageView.image = Asset.icFood.image
        case .garbage:
            iconImageView.image = Asset.icGarbage.image
        case .wifi:
            iconImageView.image = Asset.icWifi.image
        case .outlet:
            iconImageView.image = Asset.icOutlet.image
        default: return
        }
    }
}
