//
//  RecordTextViewFormTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import UIKit

class RecordTextViewFormTableViewCell: UITableViewCell {
    @IBOutlet var memoTextLabel: PlaceHolderTextView!

    struct Component {
        enum Event {
            case doneTapped
        }

        var memoText: String
        var event: (Event) -> Void
    }

    private var component: Component?

    func configure(component: Component) {
        self.component = component
        memoTextLabel.delegate = self
        memoTextLabel.placeholder = "作業メモを入力してください"

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 375, height: 40))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        toolbar.setItems([space, done], animated: true)
        memoTextLabel.inputAccessoryView = toolbar
    }

    @objc private func doneTapped() {
        component?.event(.doneTapped)
    }
}

extension RecordTextViewFormTableViewCell: UITextViewDelegate {}
