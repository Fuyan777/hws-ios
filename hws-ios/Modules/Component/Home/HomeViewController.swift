//
//  HomeViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import RxSwift
import SDWebImage
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel
            tableView.delegate = viewModel
            let nibs = [
                SpaceTableViewCell.self
            ]
            tableView.registerNib(cellTypes: nibs)
        }
    }

    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()

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
        viewModel.getSpace()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = L10n.Navigation.homeTitle
    }

    private func bindViewModel() {
        viewModel.reloadData.asObservable().subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.alertError.asObservable().subscribe(onNext: { [weak self] error in
            self?.alertError(error: error)
        }).disposed(by: disposeBag)
    }
}
