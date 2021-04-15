//
//  RootViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import RxCocoa
import RxSwift

class RootViewModel {
    struct Dependency {
        var router: RootRouting

        static func `default`(router: RootRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    let showTab = PublishRelay<Void>()

    private let dependency: Dependency
    private let model: RootModel
    private let disposeBag = DisposeBag()

    init(dependency: Dependency) {
        self.dependency = dependency
        model = RootModel()
        bindModel()
    }

    func setupContents() {
        model.setupContents()
    }

    func setupTab() {
        dependency.router.resetAll()
    }

    private func bindModel() {
        model.showTab.asObservable().subscribe(onNext: { [weak self] _ in
            self?.showTab.accept(())
        }).disposed(by: disposeBag)
    }
}
