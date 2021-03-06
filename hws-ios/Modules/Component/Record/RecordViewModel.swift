//
//  RecordViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import Foundation
import RxRelay
import RxSwift
import UIKit

final class RecordViewModel: NSObject {
    struct Dependency {
        let router: RecordRouting

        static func `default`(router: RecordRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    private let model: RecordModel
    private let dependency: Dependency
    weak var delegate: RecordListUpdateDelegate?
    private let disposeBag = DisposeBag()

    let didTapDoneButton = PublishRelay<Void>()
    let didTapCancelButton = PublishRelay<Void>()
    let barButtonItem = PublishRelay<UIBarButtonItem>()
    let reloadData = PublishRelay<Void>()
    let alertError = PublishRelay<Error>()
    let alertValidationError = PublishRelay<Void>()

    init(model: RecordModel, dependency: Dependency, delegate: RecordListUpdateDelegate?) {
        self.model = model
        self.dependency = dependency
        self.delegate = delegate
        super.init()
        bindModel()
    }

    func setBarButtonItem() {
        let rightButton = UIBarButtonItem(
            title: "追加",
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        rightButton.tintColor = Asset.accentColor.color
        barButtonItem.accept(rightButton)
    }

    func getSpaceName() {
        model.getSpaceName()
    }

    @objc
    func addButtonTapped() {
        guard model.addRecordItemsWithValidation() else { return }
        dependency.router.dismiss {
            self.delegate?.updateList()
        }
    }

    private func bindModel() {
        model.requestSuccess.asObservable().subscribe(onNext: { [weak self] _ in
            self?.reloadData.accept(())
        }).disposed(by: disposeBag)

        model.requestError.asObservable().subscribe(onNext: { [weak self] error in
            self?.alertError.accept(error)
        }).disposed(by: disposeBag)

        model.validationError.asObservable().subscribe(onNext: { [weak self] _ in
            self?.alertValidationError.accept(())
        }).disposed(by: disposeBag)
    }
}

extension RecordViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.cellTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch model.cellTypes[indexPath.row] {
        case .startDate:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordFormTableViewCell
            let component = RecordFormTableViewCell.Component(title: model.cellTypes[indexPath.row].title) { event in
                switch event {
                case let .selectedDate(date):
                    self.model.update(startDate: date)
                }
            }
            cell.configure(component: component)
            return cell
        case .endDate:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordFormTableViewCell
            let component = RecordFormTableViewCell.Component(title: model.cellTypes[indexPath.row].title) { event in
                switch event {
                case let .selectedDate(date):
                    self.model.update(endDate: date)
                }
            }
            cell.configure(component: component)
            return cell
        case .location:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordPickerFormTableViewCell
            let component = RecordPickerFormTableViewCell.Component(
                title: model.cellTypes[indexPath.row].title,
                list: model.spacesNameArray
            ) { event in
                switch event {
                case let .doneTapped(selectedItems):
                    self.model.update(locationName: selectedItems)
                    self.didTapDoneButton.accept(())
                case .cancelTapped:
                    self.didTapCancelButton.accept(())
                }
            }
            cell.configure(component: component)
            return cell
        case .congestion:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordPickerFormTableViewCell
            let component = RecordPickerFormTableViewCell.Component(
                title: model.cellTypes[indexPath.row].title,
                list: ["快適", "普通", "混雑"]
            ) { event in
                switch event {
                case let .doneTapped(selectedItems):
                    self.model.update(congestionName: selectedItems)
                    self.didTapDoneButton.accept(())
                case .cancelTapped:
                    self.didTapCancelButton.accept(())
                }
            }
            cell.configure(component: component)
            return cell
        case .memo:
            let cell = tableView.dequeueReusableCell(for: indexPath) as RecordTextViewFormTableViewCell
            let component = RecordTextViewFormTableViewCell.Component(memoText: model.cellTypes[indexPath.row].title) { event in
                switch event {
                case let .doneTapped(text):
                    self.model.update(memo: text)
                    self.didTapDoneButton.accept(())
                }
            }
            cell.configure(component: component)
            return cell
        }
    }
}

extension RecordViewModel: UITableViewDelegate {}

protocol RecordListUpdateDelegate: AnyObject {
    func updateList()
}
