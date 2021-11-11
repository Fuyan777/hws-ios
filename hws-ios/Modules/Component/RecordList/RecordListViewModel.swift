//
//  RecordListViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/06.
//

import Foundation
import RxRelay
import RxSwift
import UIKit

class RecordListViewModel: NSObject {
    struct Dependency {
        let router: RecordRouting

        static func `default`(router: RecordRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    let barButtonItem = PublishRelay<UIBarButtonItem>()

    private let dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
        super.init()
    }

    func setBarButtonItem() {
        let rightButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        rightButton.tintColor = Asset.accentColor.color
        barButtonItem.accept(rightButton)
    }

    @objc
    func addButtonTapped() {
        dependency.router.pushRecord()
    }
}

extension RecordListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as RecordListTableViewCell
        let component = RecordListTableViewCell.Component(
            title: "函館 つたや",
            date: "2021年4月21日",
            imageType: .comfortable
        )
        cell.configure(component: component)
        return cell
    }
}

extension RecordListViewModel: UITableViewDelegate {}
