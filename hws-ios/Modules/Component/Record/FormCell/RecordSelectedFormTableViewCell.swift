//
//  RecordSelectedFormTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import UIKit

class RecordSelectedFormTableViewCell: UITableViewCell {
    @IBOutlet var congestionButton: UIButton! {
        didSet { congestionButton.addTarget(self, action: #selector(didTapCongestionButton), for: .touchUpInside) }
    }

    @IBOutlet var normalButton: UIButton! {
        didSet { normalButton.addTarget(self, action: #selector(didTapNormalButton), for: .touchUpInside) }
    }

    @IBOutlet var comfortableButton: UIButton! {
        didSet { comfortableButton.addTarget(self, action: #selector(didTapComfortableButton), for: .touchUpInside) }
    }

    struct Component {
        enum Event {
            case congestionButton, normalButton, comfortableButton
        }

        var event: (Event) -> Void
        func didTapCongestionButton() { event(.congestionButton) }
        func didTapNormalButton() { event(.normalButton) }
        func didTapComfortableButton() { event(.comfortableButton) }
    }

    private var component: Component?

    func configure(component: Component) {
        self.component = component
        congestionButton.setTitle("", for: .normal)
        congestionButton.setImage(Asset.icCongestion.image, for: .normal)

        normalButton.setTitle("", for: .normal)
        normalButton.setImage(Asset.icNormal.image, for: .normal)

        comfortableButton.setTitle("", for: .normal)
        comfortableButton.setImage(Asset.icComfortable.image, for: .selected)
    }
}

private extension RecordSelectedFormTableViewCell {
    func changeButtonStatus() {}

    @objc
    func didTapCongestionButton() {
        component?.didTapCongestionButton()
    }

    @objc
    func didTapNormalButton() {
        component?.didTapNormalButton()
    }

    @objc
    func didTapComfortableButton() {
        component?.didTapComfortableButton()
    }
}
