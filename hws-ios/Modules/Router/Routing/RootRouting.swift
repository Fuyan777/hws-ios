//
//  RootRouting.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import UIKit

protocol RootRouting: AnyObject {
    var container: RootViewController { get }

    func start(in window: UIWindow)
    func resetAll()
    func showTabPages()
}
