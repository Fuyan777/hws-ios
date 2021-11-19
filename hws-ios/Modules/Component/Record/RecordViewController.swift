//
//  RecordViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import UIKit

final class RecordViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel
            tableView.delegate = viewModel
            let nibs = [
                RecordFormTableViewCell.self,
                RecordPickerFormTableViewCell.self,
                RecordTextViewFormTableViewCell.self,
                RecordSelectedFormTableViewCell.self
            ]
            tableView.registerNib(cellTypes: nibs)
        }
    }

    private let viewModel: RecordViewModel

    init(viewModel: RecordViewModel) {
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
