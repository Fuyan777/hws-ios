//
//  RecordViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import RxSwift
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
    private let disposeBag = DisposeBag()

    init(viewModel: RecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setBarButtonItem()
        viewModel.getSpaceName()
    }

    private func bindViewModel() {
        viewModel.didTapDoneButton.asObservable().subscribe(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)

        viewModel.didTapCancelButton.asObservable().subscribe(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)

        viewModel.barButtonItem.asObservable().subscribe(onNext: { [weak self] barButton in
            self?.navigationItem.rightBarButtonItem = barButton
        }).disposed(by: disposeBag)

        viewModel.reloadData.asObservable().subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.alertError.asObservable().subscribe(onNext: { [weak self] error in
            self?.alertError(error: error)
        }).disposed(by: disposeBag)

        viewModel.alertValidationError.asObservable().subscribe(onNext: { [weak self] _ in
            self?.alertMessage("項目を全て記入してください")
        }).disposed(by: disposeBag)
    }
}
