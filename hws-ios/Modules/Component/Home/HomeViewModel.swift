//
//  HomeViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import UIKit

class HomeViewModel: NSObject {
    private let model: HomeModel
    
    init(model: HomeModel) {
        self.model = model
    }
}

extension HomeViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CategoryTableViewCell
        let component = CategoryTableViewCell.Component()
        cell.setupCell(component: component)
        return cell
    }
}
