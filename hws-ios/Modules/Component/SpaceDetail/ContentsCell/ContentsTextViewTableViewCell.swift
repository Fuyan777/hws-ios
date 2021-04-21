//
//  ContentsTextViewTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/21.
//

import UIKit

class ContentsTextViewTableViewCell: UITableViewCell {
    @IBOutlet var contentTextView: UITextView! {
        didSet {
            contentTextView.isEditable = false
            contentTextView.isScrollEnabled = false
            contentTextView.isSelectable = false
        }
    }

    struct Component {
        var text: String
    }

    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
        contentTextView.text = component.text
    }
}
