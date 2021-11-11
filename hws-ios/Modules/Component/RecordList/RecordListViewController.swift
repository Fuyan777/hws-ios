//
//  RecordListViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/06.
//

import UIKit

final class RecordListViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel
            tableView.delegate = viewModel
            let nibs = [
                RecordListTableViewCell.self
            ]
            tableView.registerNib(cellTypes: nibs)
        }
    }

    private let viewModel: RecordListViewModel

    init(viewModel: RecordListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "作業記録"

        let rightButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        rightButton.tintColor = Asset.accentColor.color
        navigationItem.rightBarButtonItem = rightButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc
    func addButtonTapped() {
        // TODO: のちほど修正
        print("tapped")
    }
}
