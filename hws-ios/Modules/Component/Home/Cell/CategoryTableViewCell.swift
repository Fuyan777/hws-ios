//
//  CategoryTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            let nibs = [
                SpaceCollectionViewCell.self
            ]
            collectionView.registerNib(cellTypes: nibs)
            collectionView.showsHorizontalScrollIndicator = false
        }
    }

    @IBOutlet var categoryTitleLabel: UILabel!

    struct Component {
        enum Event {
            case moveView
        }

        var spaceData: [GetSpacesQuery.Data.Space]
        var title: String
        var event: (Event) -> Void
    }

    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
        categoryTitleLabel.text = component.title
        collectionView.reloadData()
    }
}

extension CategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        component?.spaceData.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as SpaceCollectionViewCell
        guard let spaceData = component?.spaceData else { return UICollectionViewCell() }
        let categoryComponent = SpaceCollectionViewCell.Component(
            spaceUrlString: spaceData[indexPath.row].image,
            spaceName: spaceData[indexPath.row].name
        )
        cell.setupCell(component: categoryComponent)
        return cell
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        component?.event(.moveView)
    }
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
    }
}
