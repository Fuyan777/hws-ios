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

    func pushSpaceDetail(spaceData: GetSpacesQuery.Data.Space) {
        let viewModel = SpaceDetailViewModel(model: SpaceDetailModel(spaceDetail: spaceData))
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

    func select(tab: Tab) {
        tabRouter?.select(tab: tab)
    }
}
