//
//  RecordFormTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import RxCocoa
import RxSwift
import UIKit

class RecordFormTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    private var selectedDate = Date()
    private let disposeBag = DisposeBag()

    struct Component {
        enum Event {
            case selectedDate(Date)
        }

        var title: String
        var event: (Event) -> Void
    }

    private var component: Component?

    func configure(component: Component) {
        self.component = component
        titleLabel.text = component.title
        datePicker.preferredDatePickerStyle = .compact

        datePicker.rx.value.changed.asObservable().subscribe(onNext: { date in
            self.component?.event(.selectedDate(date))
        }).disposed(by: disposeBag)
    }
}
