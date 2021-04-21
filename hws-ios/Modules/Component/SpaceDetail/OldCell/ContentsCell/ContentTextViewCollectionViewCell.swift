//
//  ContentTextViewCollectionViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/17.
//

import UIKit

class ContentTextViewCollectionViewCell: UICollectionViewCell {
    @IBOutlet var contentTextView: UITextView! {
        didSet {
            contentTextView.isScrollEnabled = false
            contentTextView.isSelectable = false
            contentTextView.isEditable = false
        }
    }

    struct Component {
        var description: String
    }

    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
        contentTextView.text = component.description
    }
}
