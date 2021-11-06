//
//  FavoriteSpaceCollectionViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/07/23.
//

import UIKit

class FavoriteSpaceCollectionViewCell: UICollectionViewCell {
    @IBOutlet var baseView: UIView! {
        didSet { baseView.maskConer(corner: 8) }
    }

    @IBOutlet var spaceImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var usageTimeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
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

    @IBOutlet var moveButton: UIButton! {
        didSet {
            moveButton.maskConer()
        }
    }

    struct Component {
        var favoriteSpace: Space
    }

    private var component: Component?

    func setup(component: Component) {
        self.component = component
        titleLabel.text = component.favoriteSpace.name
        addressLabel.text = component.favoriteSpace.address

        //        TODO: バックエンドの準備が出来次第
        //        spaceImageView.setImage(urlString: component.imageUrlString)
        usageTimeLabel.isHidden = true
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
        CGSize(width: 30, height: 30)
    }
}
