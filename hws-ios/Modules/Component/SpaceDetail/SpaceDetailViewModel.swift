//
//  SpaceDetailViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import RxRelay
import RxSwift
import UIKit

class SpaceDetailViewModel: NSObject {
    struct Dependency {
        var router: SpaceDetailRouting

        static func `default`(router: SpaceDetailRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    private let dependency: Dependency
    private let disposeBag = DisposeBag()
    let model: SpaceDetailModel
    let reloadData = PublishRelay<Void>()
    let confirmAlert = PublishRelay<UIAlertController>()

    let tableSection: [TableSection] = TableSection.allCases

    init(model: SpaceDetailModel, dependency: Dependency) {
        self.model = model
        self.dependency = dependency
        super.init()
        bindModel()
    }

    func openGooleMapsRoute() {
        let pinName = model.spacesDetail.name
        var urlString = ""

        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
            urlString = "comgooglemaps://?daddr=\(pinName)&directionsmode=driving"
        }
        let encodeUrlString: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let url = URL(string: encodeUrlString) {
            UIApplication.shared.open(url)
        }
    }

    private func bindModel() {
        model.reloadData.asObservable().subscribe(onNext: { [weak self] _ in
            self?.reloadData.accept(())
        }).disposed(by: disposeBag)
    }
}

extension SpaceDetailViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableRowCount(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableSection[indexPath.section] {
        case .header:
            let cell = tableView.dequeueReusableCell(for: indexPath) as SpaceDetailHeaderTableViewCell
            let component = SpaceDetailHeaderTableViewCell.Component(
                title: model.spacesDetail.name,
                address: model.spacesDetail.address,
                isFavorite: model.isFavorite,
                imageUrlString: model.spacesDetail.image
            ) { event in
                switch event {
                case .moveMap:
                    self.dependency.router.pushMap()
                case .tapFavorite:
                    self.model.isFavorite ? self.model.deleteFavorite() : self.model.addFavorite()
                case .moveGoogleMaps:
                    self.openGooleMaps()
                case .congestionInfo:
                    let alertAction: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)]
                    let alert = UIAlertController.confirm(
                        title: L10n.Alert.congestionInfoTitle,
                        message: L10n.Alert.congestionInfoMessage,
                        type: .alert, actions: alertAction,
                        hasCancel: false
                    )
                    self.confirmAlert.accept(alert)
                }
            }
            cell.setup(component: component)
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContentsTextViewTableViewCell
            let component = ContentsTextViewTableViewCell.Component(
                text: model.spacesDetail.description
            )
            cell.setupCell(component: component)
            return cell
        case .equipment:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContentsIconTableViewCell
            let component = ContentsIconTableViewCell.Component(
                equipment: model.equipments
            )
            cell.setupCell(component: component)
            return cell
        case .attension:
            let cell = tableView.dequeueReusableCell(for: indexPath) as ContentsTextViewTableViewCell
            let component = ContentsTextViewTableViewCell.Component(
                text: "基本的に静かに作業するようにしましょう！！"
            )
            cell.setupCell(component: component)
            return cell
        }
    }
}

private extension SpaceDetailViewModel {
    func openGooleMaps() {
        let latitude = model.spacesDetail.latitude
        let longitude = model.spacesDetail.latitude
        let pinName = model.spacesDetail.name

        let urlString = "https://maps.google.com/maps?q=\(pinName)¢er\(latitude.description),\(longitude.description)"
        let encodeUrlString: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let url = URL(string: encodeUrlString) {
            UIApplication.shared.open(url)
        }
    }
}
