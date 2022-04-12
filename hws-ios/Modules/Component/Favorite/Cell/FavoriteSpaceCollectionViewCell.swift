//
//  FavoriteSpaceCollectionViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/07/23.
//

import UIKit

class FavoriteSpaceCollectionViewCell: UICollectionViewCell {
    @IBOutlet var baseView: UIView! {
        didSet {
            baseView.maskConer()
            baseView.layer.borderColor = UIColor.gray.cgColor
            baseView.layer.borderWidth = 0.5
            //            baseView.maskShadow()
        }
    }

    @IBOutlet var spaceImageView: UIImageView! {
        didSet {
            spaceImageView.layer.cornerRadius = 4
            spaceImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var equipmentCollectionView: UICollectionView! {
        didSet {
            equipmentCollectionView.dataSource = self
            equipmentCollectionView.delegate = self
            let nibs = [
                FavoriteSpaceContentIconCollectionViewCell.self
            ]
            equipmentCollectionView.registerNib(cellTypes: nibs)
            equipmentCollectionView.isScrollEnabled = false
        }
    }

    struct Component {
        var favoriteSpace: Space
    }

    private var component: Component?

    func setup(component: Component) {
        self.component = component
        titleLabel.text = component.favoriteSpace.name
//        spaceImageView.setImage(urlString: component.imageUrlString)
    }
}

extension FavoriteSpaceCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        component?.favoriteSpace.equipments.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as FavoriteSpaceContentIconCollectionViewCell
        guard let equipmentValue = component?.favoriteSpace.equipments[indexPath.row] else { return cell }
        let componentEquipment = FavoriteSpaceContentIconCollectionViewCell.ComponentFavorite(
            equipment: equipmentValue
        )
        cell.setupCell(component: componentEquipment)
        return cell
    }
}

extension FavoriteSpaceCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 40, height: 40)
    }
}
