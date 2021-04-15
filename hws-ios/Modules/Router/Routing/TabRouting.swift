//
//  TabRouting.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

protocol TabRouting: AnyObject {
    var container: TabBarController { get }

    func select(tab: Tab)
    func reset(tab: Tab)
    func resetTabPages(initalTab: Tab)
    func showTabPages()
    func selectedTab() -> Tab
}
