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

    let getResponse = PublishRelay<GetSpaceQuery.Data.Space>()
    let alertError = PublishRelay<Error>()

    private let dependency: Dependency
    private let model: HomeModel
    private let disposeBag = DisposeBag()

    init(model: HomeModel, dependency: Dependency) {
        self.model = model
        self.dependency = dependency
        super.init()
        bindModel()
        getSpace()
    }

    func getSpace() {
        model.getSpace()
    }

    private func bindModel() {
        model.requestSuccess.asObservable().subscribe(onNext: { [weak self] response in
            self?.getResponse.accept(response)
        }).disposed(by: disposeBag)

        model.requestError.asObservable().subscribe(onNext: { [weak self] error in
            self?.alertError.accept(error)
        }).disposed(by: disposeBag)
    }
}

extension HomeViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CategoryTableViewCell
        let component = CategoryTableViewCell.Component { event in
            switch event {
            case .moveView:
                self.dependency.router.pushSpaceDetail()
            }
        }
        cell.setupCell(component: component)
        return cell
    }
}
