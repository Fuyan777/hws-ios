//
//  UIViewExtension.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

extension UIView {
    func maskConer(corner: CGFloat = 4) {
        layer.cornerRadius = corner
    }

    // 影をつける
    func maskShadow(opacity: Float = 0.3, radius: CGFloat = 3.0) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
}
