//
//  NSObjectExtension.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/11.
//

import Foundation

extension NSObject {
    @nonobjc static var className: String {
        String(describing: self)
    }

    var className: String {
        type(of: self).className
    }
}
