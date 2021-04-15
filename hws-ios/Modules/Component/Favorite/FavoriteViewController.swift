//
//  FavoriteViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import UIKit

class FavoriteViewController: UIViewController {
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
    }
}
