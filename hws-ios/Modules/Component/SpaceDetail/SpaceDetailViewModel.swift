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

    let tableSection: [TableSection] = TableSection.allCases

    init(model: SpaceDetailModel, dependency: Dependency) {
        self.model = model
        self.dependency = dependency
        super.init()
        bindModel()
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
                isFavorite: model.isFavorite
            ) { event in
                switch event {
                case .moveMap:
                    self.dependency.router.pushMap()
                case .tapFavorite:
                    self.model.isFavorite ? self.model.deleteFavorite() : self.model.addFavorite()
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
