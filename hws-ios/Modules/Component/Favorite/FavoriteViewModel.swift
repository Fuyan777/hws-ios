//
//  FavoriteViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import UIKit

class FavoriteViewModel: NSObject {
    struct Dependency {
        let router: FavoriteRouting

        static func `default`(router: FavoriteRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    private let dependency: Dependency
    var model: FavoriteModel

    init(model: FavoriteModel, dependency: Dependency) {
        self.model = model
        self.dependency = dependency
    }

    func tappedCellAction(index: Int) {
        dependency.router.pushSpaceDetail(favoriteSpace: model.favoriteSpaces[index])
    }
}

extension FavoriteViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.dataCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as FavoriteSpaceCollectionViewCell
        let component = FavoriteSpaceCollectionViewCell.Component(
            favoriteSpace: model.favoriteSpaces[indexPath.row]
        )
        cell.setup(component: component)
        return cell
    }
}
