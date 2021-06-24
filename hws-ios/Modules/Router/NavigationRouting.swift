//
//  NavigationRouting.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import UIKit

protocol NavigationRouting: HomeRouting,
                            SpaceDetailRouting,
                            SettingRouting {
    var container: UINavigationController { get }
}
