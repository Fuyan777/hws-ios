//
//  SettingViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/06/18.
//

import RxRelay
import UIKit

class SettingViewModel: NSObject {
    struct Dependency {
        let router: SettingRouting

        static func `default`(router: SettingRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    let presentVC = PublishRelay<UIActivityViewController>()

    private var model: SettingModel
    private let dependency: Dependency

    init(model: SettingModel, dependency: Dependency) {
        self.model = model
        self.dependency = dependency
    }
}

extension SettingViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        model.tableSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.tableSection[section].rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingType = model.tableSection[indexPath.section]
        let cell = tableView.dequeueReusableCell(for: indexPath) as SettingTableViewCell
        let component = SettingTableViewCell.Component(
            title: settingType.rowTitle(rowIndex: indexPath.row),
            iconImage: settingType.rowIconImage(rowIndex: indexPath.row)
        )
        cell.setup(component: component)
        return cell
    }

    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        48
    }

    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewFrame = CGRect(origin: .zero, size: CGSize(width: tableView.bounds.width, height: 48))
        let tableViewHeaderView = UIView(frame: headerViewFrame)
        tableViewHeaderView.backgroundColor = .lightGray

        let headerLabelFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 20))
        let headerLabel = UILabel(frame: headerLabelFrame)
        headerLabel.center = CGPoint(x: 116, y: tableViewHeaderView.center.y)
        headerLabel.text = model.tableSection[section].title
        headerLabel.textColor = .black
        headerLabel.font = UIFont.boldSystemFont(ofSize: 17)

        tableViewHeaderView.addSubview(headerLabel)

        return tableViewHeaderView
    }
}

extension SettingViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingType = model.tableSection[indexPath.section]
        switch settingType {
        case .app:
            let appRow = settingType.appRows[indexPath.row]
            switch appRow {
            case .request:
                dependency.router.presentSafariBrowser(url: URL(string: Endpoint.requestFormPath)!)
            case .appShare:
                let text = "アプリをシェア"
                let items: [Any?] = [text]
                let activityVC = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
                presentVC.accept(activityVC)
            case .appReview:
                dependency.router.presentSafariBrowser(url: URL(string: Endpoint.reviewPath)!)
            }
        case .other:
            let ohterRow = settingType.otherRows[indexPath.row]
            switch ohterRow {
            case .privacyPolicy:
                dependency.router.presentSafariBrowser(url: URL(string: Endpoint.privacyPolicyPath)!)
            case .version: break
            }
        }
    }
}
