//
//  HomeViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import RxRelay
import RxSwift
import UIKit

class HomeViewModel: NSObject {
    struct Dependency {
        let router: HomeRouting

        static func `default`(router: HomeRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    let reloadData = PublishRelay<Void>()
    let alertError = PublishRelay<Error>()

    private let dependency: Dependency
    private let model: HomeModel
    private let disposeBag = DisposeBag()

    init(model: HomeModel, dependency: Dependency) {
        self.model = model
        self.dependency = dependency
        super.init()
        bindModel()
    }

    func getSpace() {
        model.getSpace()
    }

    private func bindModel() {
        model.requestSuccess.asObservable().subscribe(onNext: { [weak self] _ in
            self?.reloadData.accept(())
        }).disposed(by: disposeBag)

        model.requestError.asObservable().subscribe(onNext: { [weak self] error in
            self?.alertError.accept(error)
        }).disposed(by: disposeBag)
    }
}

extension HomeViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.tableSection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CategoryTableViewCell
        let component = CategoryTableViewCell.Component(
            spaceData: model.spacesData,
            title: model.tableSection[indexPath.row].title
        ) { event in
            switch event {
            case let .moveView(index):
                self.dependency.router.pushSpaceDetail(spaceData: self.model.spacesData[index])
            }
        }
        cell.setupCell(component: component)
        return cell
    }
}
