//
//  SpaceDetailContentsTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/17.
//

import UIKit

class SpaceDetailContentsTableViewCell: UITableViewCell {
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            let nibs = [
                ContentTextViewCollectionViewCell.self,
                ContentIconCollectionViewCell.self
            ]
            collectionView.registerNib(cellTypes: nibs)
        }
    }

    struct Component {
        var contentName: String
        var contentzType: ContentItem
    }

    enum ContentItem: CaseIterable {
        case spaceDescription, equipment, attension
    }

    private var contentItem: ContentItem = .spaceDescription
    private var component: Component?

    func setupCell(component: Component) {
        self.component = component
        contentsLabel.text = component.contentName
        contentItem = component.contentzType
    }
}

extension SpaceDetailContentsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch contentItem {
        case .equipment:
            return 4
        default:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contentItem {
        case .spaceDescription:
            let cell = collectionView.dequeueReusableCell(for: indexPath) as ContentTextViewCollectionViewCell
            let component = ContentTextViewCollectionViewCell.Component(
                description: """
                北海道函館市で電源コンセントを利用できるコーヒーショップやファーストフード、カフェ、コンビニイートインスペース、フードコートなどの電源スポット・充電スポットの一覧。函館市では，観光で本市を訪れる外国人の皆様に快適に過ごしていただけるよう公衆無線LAN環境の整備を行いました。現在は，以下の場所においてHAKODATE FREE Wi-Fi（ハコダテ　フリー　ワイファイ）を利用することができます。
                """
            )
            cell.setupCell(component: component)
            return cell
        case .equipment:
            let cell = collectionView.dequeueReusableCell(for: indexPath) as ContentIconCollectionViewCell
            let component = ContentIconCollectionViewCell.Component()
            cell.setupCell(component: component)
            return cell
        case .attension:
            let cell = collectionView.dequeueReusableCell(for: indexPath) as ContentTextViewCollectionViewCell
            let component = ContentTextViewCollectionViewCell.Component(
                description: """
                常識の範囲内で活動しましょう。
                """
            )
            cell.setupCell(component: component)
            return cell
        }
    }
}

extension SpaceDetailContentsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch contentItem {
        case .equipment:
            return CGSize(width: collectionView.frame.width / 8, height: collectionView.frame.height)
        default:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch contentItem {
        case .equipment:
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
