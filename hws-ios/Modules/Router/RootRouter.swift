//
//  RootRouter.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import UIKit

final class RootRouter: RootRouting {
    private lazy var tabRouter: TabRouting = TabRouter(rootRouter: self)
    private lazy var rootViewModel = RootViewModel(dependency: .default(router: self))
    private(set) lazy var container = RootViewController(viewModel: rootViewModel)

    func start(in window: UIWindow) {
        window.rootViewController = container
        window.makeKeyAndVisible()
    }

    func resetAll() {
        for viewContoller in container.children {
            viewContoller.removeFromParentViewController()
        }
        showTabPages()
        if container.presentedViewController != nil {
            container.dismiss(animated: true)
        }
    }

    func showTabPages() {
        if tabRouter.container.parent == nil {
            container.addChild(tabRouter.container, to: container.view)
        }
        tabRouter.resetTabPages(initalTab: .home)
    }
}
