//
//  SettingViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/18.
//

import RxRelay
import RxSwift
import UIKit

class SettingViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel
            tableView.delegate = viewModel
            let nibs = [
                SettingTableViewCell.self
            ]
            tableView.registerNib(cellTypes: nibs)
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0
            }
        }
    }

    private let viewModel: SettingViewModel
    private let disposeBag = DisposeBag()

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
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.presentVC.asObservable().subscribe(onNext: { [weak self] activityVC in
            self?.present(activityVC, animated: true)
        }).disposed(by: disposeBag)
    }
}
