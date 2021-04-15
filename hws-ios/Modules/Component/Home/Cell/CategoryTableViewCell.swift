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

    struct Component {}

    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
    }
}

extension CategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as SpaceCollectionViewCell
        let component = SpaceCollectionViewCell.Component()
        cell.setupCell(component: component)
        return cell
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
