//
//  NavigationRouter.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import SafariServices
import UIKit

final class NavigationRouter: NavigationRouting {
    let container = UINavigationController()
    private weak var tabRouter: TabRouting?

    init(tabRouter: TabRouting?) {
        self.tabRouter = tabRouter
    }

    func select(tab: Tab) {
        tabRouter?.select(tab: tab)
    }

    func pushSpaceDetail(spaceData: Space) {
        let viewModel = SpaceDetailViewModel(
            model: SpaceDetailModel(spacesDetail: spaceData),
            dependency: .default(router: self)
        )
        let controller = SpaceDetailViewController(viewModel: viewModel)
        container.pushViewController(controller, animated: true)
    }

    func presentSafariBrowser(url: URL) {
        let router = NavigationRouter(tabRouter: tabRouter)
        let controller = SFSafariViewController(url: url)
        controller.dismissButtonStyle = .close
        router.container.viewControllers = [controller]
        router.container.navigationBar.isHidden = true
        container.present(router.container, animated: true)
    }

    func pushMap() {
        let viewModel = MapViewModel(
            model: MapModel()
        )
        let controller = MapViewController(viewModel: viewModel)
        container.pushViewController(controller, animated: true)
    }

    func pushSetting() {
        let viewModel = SettingViewModel(
            model: SettingModel(),
            dependency: .default(router: self)
        )
        let controller = SettingViewController(viewModel: viewModel)
        container.pushViewController(controller, animated: true)
    }

    func presentRecord(delegate: RecordListUpdateDelegate?) {
        let router = NavigationRouter(tabRouter: tabRouter)
        let viewModel = RecordViewModel(
            model: RecordModel(),
            dependency: .default(router: router),
            delegate: delegate
        )
        let controller = RecordViewController(viewModel: viewModel)
        router.container.viewControllers = [controller]
        container.present(router.container, animated: true)
    }

    func presentMap() {
        let router = NavigationRouter(tabRouter: tabRouter)
        let viewModel = MapViewModel(model: MapModel())
        let controller = MapViewController(viewModel: viewModel)
        router.container.viewControllers = [controller]
        controller.present(router.container, animated: true)
    }

    func dismiss() {
        dismiss(completion: nil)
    }

    func dismiss(completion: (() -> Void)?) {
        dismiss(animated: true, completion: completion)
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        container.dismiss(
            animated: animated
        ) { [weak container] in
            completion?()
            container?.viewControllers.removeAll()
        }
    }

    func pop() {
        container.popViewController(animated: true)
    }
}
