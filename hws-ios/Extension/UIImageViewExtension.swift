//
//  UIImageViewExtension.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/30.
//

import SDWebImage
import UIKit

extension UIImageView {
    func setImage(urlString: String, completion: ((UIImage?) -> Void)? = nil) {
        if let url = URL(string: urlString) {
            sd_setImage(with: url) { webImage, error, _, _ in
                if error != nil {
                    completion?(self.image)
                    return
                }
                completion?(webImage)
            }
            return
        }
        completion?(image)
    }
}
