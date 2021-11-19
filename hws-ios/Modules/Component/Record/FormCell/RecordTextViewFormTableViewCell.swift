//
//  RecordTextViewFormTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import UIKit

class RecordTextViewFormTableViewCell: UITableViewCell {
    @IBOutlet var memoTextLabel: UITextView!

    struct Component {
        var memoText: String
    }

    private var component: Component?

    func configure(component: Component) {
        memoTextLabel.text = component.memoText
    }
}
