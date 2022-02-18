//
//  RecordPickerFormTableViewCell.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import UIKit

class RecordPickerFormTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationTextField: UITextField!

    private var pickerView = UIPickerView()
    private var selectedItems: String = ""

    struct Component {
        enum Event {
            case doneTapped(String), cancelTapped
        }

        var title: String
        var list: [String]
        var viewWidth: CGFloat
        var event: (Event) -> Void
    }

    private var component: Component?

    func configure(component: Component) {
        self.component = component
        titleLabel.text = component.title
        setTextField()
    }

    private func setTextField() {
        pickerView.delegate = self
        pickerView.dataSource = self
        locationTextField.inputView = pickerView

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 375, height: 50))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        toolbar.setItems([cancel, space, done], animated: true)
        locationTextField.inputAccessoryView = toolbar
    }

    @objc private func doneTapped() {
        component?.event(.doneTapped(selectedItems))
    }

    @objc private func cancelTapped() {
        component?.event(.cancelTapped)
    }
}

extension RecordPickerFormTableViewCell: UIPickerViewDelegate {}

extension RecordPickerFormTableViewCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.component?.list.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.component?.list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItems = self.component?.list[row] ?? "選択なし"
        locationTextField.text = self.component?.list[row] ?? "選択なし"
    }
}
