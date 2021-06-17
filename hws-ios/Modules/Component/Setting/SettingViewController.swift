//
//  SettingViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/18.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel
            let nibs = [
                SettingTableViewCell.self
            ]
            tableView.registerNib(cellTypes: nibs)
        }
    }

    private let viewModel: SettingViewModel

    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = L10n.Navigation.settingTitle
    }
}
