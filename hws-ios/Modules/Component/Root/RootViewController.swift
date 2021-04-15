//
//  RootViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/07.
//

import RxSwift
import UIKit

final class RootViewController: UIViewController {
    private let viewModel: RootViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.setupContents()
    }

    private func bindViewModel() {
        viewModel.showTab.asObservable().subscribe(onNext: { [weak self] _ in
            self?.showTab()
        }).disposed(by: disposeBag)
    }

    private func showTab() {
        rx.viewWillAppear.take(1).subscribe(onNext: { [weak self] in
            self?.viewModel.setupTab()
        }).disposed(by: disposeBag)
    }
}
