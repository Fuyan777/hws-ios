//
//  AppDelegate.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/07.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let router = RootRouter()
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        router.start(in: window)
        return true
    }
}
