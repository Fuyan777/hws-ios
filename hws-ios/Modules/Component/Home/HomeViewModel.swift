//
//  HomeViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import UIKit

class HomeViewModel: NSObject {
    struct Dependency {
        let router: HomeRouting

        static func `default`(router: HomeRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    private let dependency: Dependency
    private let model: HomeModel

    init(model: HomeModel, dependency: Dependency) {
        self.model = model
        self.dependency = dependency
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
