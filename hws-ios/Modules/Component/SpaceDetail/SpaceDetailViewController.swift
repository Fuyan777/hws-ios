//
//  SpaceDetailViewController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import RxSwift
import UIKit

class SpaceDetailViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = viewModel
            let nibs = [
                SpaceDetailHeaderTableViewCell.self,
                ContentsTextViewTableViewCell.self,
                ContentsIconTableViewCell.self
            ]
            tableView.registerNib(cellTypes: nibs)
        }
    }

    @IBOutlet var goSpaceButton: UIButton!

    private let viewModel: SpaceDetailViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: SpaceDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        goSpaceButton.maskConer()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.reloadData.asObservable().subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension SpaceDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel.tableHeightForHeader(section: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        viewModel.viewForHeader(section: section, view: view)
    }

    // セクションが上に来た際に隠れるようにする
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeaderHeight: CGFloat = 60.0
        if scrollView.contentOffset.y < sectionHeaderHeight, scrollView.contentOffset.y > 0 {
            scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        } else if scrollView.contentOffset.y > sectionHeaderHeight {
            scrollView.contentInset = UIEdgeInsets(top: -sectionHeaderHeight, left: 0, bottom: 0, right: 0)
        }
    }
}
