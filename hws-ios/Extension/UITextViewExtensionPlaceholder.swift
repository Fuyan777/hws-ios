//
//  UITextViewExtensionPlaceholder.swift
//  hws-ios
//
//  Created by 山田楓也 on 2022/02/20.
//

import Foundation
import UIKit

class PlaceHolderTextView: UITextView {
    var placeholder: String = "" {
        willSet {
            placeholderLabel.text = newValue
            placeholderLabel.sizeToFit()
        }
    }

    lazy var placeholderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 2.0, y: 8.0, width: 0.0, height: 0.0))
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.backgroundColor = .clear
        self.addSubview(label)
        return label
    }()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        changeVisiblePlaceholder()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textChanged),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }

    private func changeVisiblePlaceholder() {
        placeholderLabel.isHidden = !(placeholder.isEmpty || text.isEmpty)
    }

    @objc
    private func textChanged(notification: NSNotification?) {
        changeVisiblePlaceholder()
    }
}
