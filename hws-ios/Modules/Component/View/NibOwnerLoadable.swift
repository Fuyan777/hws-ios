//
//  NibOwnerLoadable.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/20.
//

import UIKit

public protocol NibOwnerLoadable: NibBundler {}

public extension NibOwnerLoadable where Self: UIView {
    func loadNibContent() {
        for case let view as UIView in Self.nib.instantiate(withOwner: self, options: nil) {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: topAnchor),
                view.rightAnchor.constraint(equalTo: rightAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.leftAnchor.constraint(equalTo: leftAnchor)
            ])
        }
    }
}
