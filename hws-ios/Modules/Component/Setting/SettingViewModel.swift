//
//  SettingViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/18.
//

import UIKit

class SettingViewModel: NSObject {}

extension SettingViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SettingTableViewCell
        let component = SettingTableViewCell.Component(
            title: "アプリについて"
        )
        cell.setupCell(component: component)
        return cell
    }
}
