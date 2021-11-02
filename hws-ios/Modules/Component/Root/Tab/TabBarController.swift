//
//  TabBarController.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import RxCocoa
import RxSwift
import UIKit

final class TabBarController: UITabBarController {
    private let disposeBag = DisposeBag()
    private let viewModel: TabBarViewModel

    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance

            guard let tabBarController = tabBarController else { return }
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .white
            tabBarController.tabBar.standardAppearance = tabBarAppearance
            tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        tabBar.tintColor = .black
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
    }
}
