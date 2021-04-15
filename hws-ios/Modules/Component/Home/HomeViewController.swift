//
//  HomeViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel
            let nibs = [
                CategoryTableViewCell.self
            ]
            tableView.registerNib(cellTypes: nibs)
        }
    }

    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
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
