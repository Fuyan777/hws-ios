//
//  TabBarViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import RxCocoa
import RxSwift

class TabBarViewModel {
    struct Dependency {
        var router: TabBarRouting
        
        static func `default`(router: TabBarRouting) -> Dependency {
            Dependency(router: router)
        }
    }
    
    private let dependency: Dependency
    private let disposeBag = DisposeBag()
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
}
