//
//  TabRouter.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import UIKit

final class TabRouter: TabRouting, TabBarRouting {
    private(set) lazy var container = TabBarController(
        viewModel: TabBarViewModel(dependency: .default(router: self))
    )
    private lazy var homeRouter = NavigationRouter(tabRouter: self)
    private lazy var favoriteRouter = NavigationRouter(tabRouter: self)
    private lazy var recordRouter = NavigationRouter(tabRouter: self)

    private weak var rootRouter: RootRouting?

    init(rootRouter: RootRouting?) {
        self.rootRouter = rootRouter

        let controllers = Tab.allCases.map { tab -> (tab: Tab, controller: UIViewController) in
            switch tab {
            case .home:
                return (tab, homeRouter.container)
            case .favorite:
                return (tab, favoriteRouter.container)
            case .record:
                return (tab, recordRouter.container)
            }
        }
        controllers.forEach { tab, controller in
            switch tab {
            case .home:
                controller.tabBarItem = UITabBarItem(
                    title: "ホーム",
                    image: UIImage(systemName: "house"),
                    tag: tab.rawValue
                )
            case .favorite:
                controller.tabBarItem = UITabBarItem(
                    title: "お気に入り",
                    image: UIImage(systemName: "heart"),
                    tag: tab.rawValue
                )
            case .record:
                controller.tabBarItem = UITabBarItem(
                    title: "作業記録",
                    image: UIImage(systemName: "doc.plaintext"),
                    tag: tab.rawValue
                )
            }
        }
        container.viewControllers = controllers.map { $0.controller }
    }

    func select(tab: Tab) {
        container.selectedIndex = tab.rawValue
    }

    func reset(tab: Tab) {
        switch tab {
        case .home:
            let viewModel = HomeViewModel(
                model: HomeModel(),
                dependency: .default(router: homeRouter)
            )
            let controller = HomeViewController(viewModel: viewModel)
            homeRouter.container.viewControllers = [controller]
        case .favorite:
            let viewModel = FavoriteViewModel(model: FavoriteModel(), dependency: .default(router: favoriteRouter))
            let controller = FavoriteViewController(viewModel: viewModel)
            favoriteRouter.container.viewControllers = [controller]
        case .record:
            let controller = RecordListViewController(viewModel: RecordListViewModel(model: RecordListModel(), dependency: .default(router: recordRouter)))
            recordRouter.container.viewControllers = [controller]
        }
    }

    func resetTabPages(initalTab: Tab) {
        Tab.allCases.forEach(reset(tab:))
        select(tab: initalTab)
    }

    func showTabPages() {
        rootRouter?.showTabPages()
    }

    func selectedTab() -> Tab {
        Tab(rawValue: container.selectedIndex) ?? .home
    }
}
