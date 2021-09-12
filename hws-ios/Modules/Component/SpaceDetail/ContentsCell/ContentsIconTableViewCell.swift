//
//  ContentsIconTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/21.
//

import UIKit

class ContentsIconTableViewCell: UITableViewCell {
    @IBOutlet var iconCollectionView: UICollectionView! {
        didSet {
            iconCollectionView.dataSource = self
            iconCollectionView.registerNib(cellType: ContentIconCollectionViewCell.self)
            iconCollectionView.isScrollEnabled = false
        }
    }

    struct Component {
        var equipment: [EquipmentEntity]
    }

    var component: Component?

    func setupCell(component: Component) {
        self.component = component
    }
}

extension ContentsIconTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        component?.equipment.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ContentIconCollectionViewCell
        guard let component = self.component else { return cell }
        let contentIconComponent = ContentIconCollectionViewCell.Component(
            equipment: component.equipment[indexPath.row]
        )
        cell.setupCell(component: contentIconComponent)
        return cell
    }
}
