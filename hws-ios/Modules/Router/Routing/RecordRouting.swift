//
//  RecordRouting.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/11/11.
//

import Foundation

protocol RecordRouting: AnyObject {
    func presentRecord(delegate: RecordListUpdateDelegate?)
    func dismiss(completion: (() -> Void)?)
}
