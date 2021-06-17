//
//  FavoriteViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import UIKit

class FavoriteViewModel: NSObject {}

extension FavoriteViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SpaceTableViewCell
        let component = SpaceTableViewCell.Component(
            imageUrlString: "sss",
            title: "五稜郭"
        )
        cell.setupCell(component: component)
        return cell
    }
}
