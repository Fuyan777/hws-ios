//
//  SpaceCollectionViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/15.
//

import UIKit

class SpaceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var spaceImageView: UIImageView! {
        didSet {
            spaceImageView.maskConer()
        }
    }
    
    @IBOutlet weak var spaceName: UILabel!
    
    struct Component {
        
    }
    
    private var component: Component?
    
    func setupCell(component: Component) {
        self.component = component
    }
}
