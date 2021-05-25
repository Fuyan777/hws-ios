//
//  UIViewControllerExtension.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/09.
//

import RxSwift
import SVProgressHUD
import UIKit

extension UIViewController {
    func addChild(_ controller: UIViewController, to view: UIView) {
        addChild(controller)
        controller.view.frame = view.bounds
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }

    func removeFromParentViewController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

// Alert
extension UIViewController {
    func alertMessage(_ message: String, delay: TimeInterval = 2.0) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.showInfo(withStatus: message)
        SVProgressHUD.dismiss(withDelay: delay)
    }

    func alertError(error: Error) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.showInfo(withStatus: error.localizedDescription)
        SVProgressHUD.dismiss(withDelay: 2.0)
    }
}

// MARK: - Rx

extension Reactive where Base: UIViewController {
    var viewWillAppear: Observable<Void> {
        methodInvoked(#selector(base.viewWillAppear(_:))).map { _ in () }
    }

    var viewDidAppear: Observable<Void> {
        methodInvoked(#selector(base.viewDidAppear(_:))).map { _ in () }
    }
}
