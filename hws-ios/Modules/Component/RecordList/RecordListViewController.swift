//
//  RecordListViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/06.
//

import RxSwift
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
    private let disposeBag = DisposeBag()

    init(viewModel: RecordListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "作業記録"
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setBarButtonItem()
    }

    private func bindViewModel() {
        viewModel.barButtonItem.asObservable().subscribe(onNext: { [weak self] barButton in
            self?.navigationItem.rightBarButtonItem = barButton
        }).disposed(by: disposeBag)

        viewModel.deleteIndexPath.asObservable().subscribe(onNext: { [weak self] index in
            self?.tableView.deleteRows(at: [index], with: .automatic)
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.reloadData.asObservable().subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}
