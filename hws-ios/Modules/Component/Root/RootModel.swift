//
//  RootModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import RxRelay

class RootModel {
    struct Dependency {
        static var `default` = Dependency()
    }

    let showTab = PublishRelay<Void>()

    let dependency: Dependency

    init(dependency: Dependency = .default) {
        self.dependency = dependency
    }

    func setupContents() {
        showTab.accept(())
    }
}
