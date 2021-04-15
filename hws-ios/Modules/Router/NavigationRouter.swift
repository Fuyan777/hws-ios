//
//  NavigationRouter.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

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
}
