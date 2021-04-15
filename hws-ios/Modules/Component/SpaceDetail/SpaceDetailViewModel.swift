//
//  SpaceDetailViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

class SpaceDetailViewModel: NSObject {}

extension SpaceDetailViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SpaceHeaderTableViewCell
        let component = SpaceHeaderTableViewCell.Component()
        cell.setupCell(component: component)
        return cell
    }
}
