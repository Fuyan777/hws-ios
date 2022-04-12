//
//  HomeViewModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import RxRelay
import RxSwift
import UIKit

class HomeViewModel: NSObject {
    struct Dependency {
        let router: HomeRouting

        static func `default`(router: HomeRouting) -> Dependency {
            Dependency(router: router)
        }
    }

    let reloadData = PublishRelay<Void>()
    let alertError = PublishRelay<Error>()
    let barButtonItem = PublishRelay<UIBarButtonItem>()

    private let dependency: Dependency
    private let model: HomeModel
    private let disposeBag = DisposeBag()

    init(model: HomeModel, dependency: Dependency) {
        self.model = model
        self.dependency = dependency
        super.init()
        bindModel()
    }

    func getSpace() {
        model.getSpace()
    }

    private func bindModel() {
        model.requestSuccess.asObservable().subscribe(onNext: { [weak self] _ in
            self?.reloadData.accept(())
        }).disposed(by: disposeBag)

        model.requestError.asObservable().subscribe(onNext: { [weak self] error in
            self?.alertError.accept(error)
        }).disposed(by: disposeBag)
    }

    func setBarButtonItem() {
        let rightButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingButtonTapped)
        )
        rightButton.tintColor = Asset.accentColor.color
        barButtonItem.accept(rightButton)
    }

    @objc
    func settingButtonTapped() {
        dependency.router.pushSetting()
    }
}

extension HomeViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.spacesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SpaceTableViewCell
        let component = SpaceTableViewCell.Component(space: model.spacesData[indexPath.row])
        cell.setup(component: component)
        return cell
    }
}

extension HomeViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dependency.router.pushSpaceDetail(spaceData: model.spacesData[indexPath.row])
    }
}
