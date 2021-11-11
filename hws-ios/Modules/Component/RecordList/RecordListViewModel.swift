//
//  RecordListViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/06.
//

import Foundation
import UIKit

class RecordListViewModel: NSObject {}

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
