//
//  FavoriteViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = viewModel
            collectionView.delegate = self
            let nibs = [
                FavoriteSpaceCollectionViewCell.self
            ]
            collectionView.registerNib(cellTypes: nibs)
            collectionView.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        }
    }

    private let viewModel: FavoriteViewModel

    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.Navigation.favoriteTitle
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellSize = view.bounds.width - 8
        return CGSize(width: cellSize, height: 200.0)
    }
}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.tappedCellAction(index: indexPath.row)
    }
}
