//
//  RecordListModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2022/02/20.
//

import Foundation

class RecordListModel {
    var localdata = RealmManager()
    var dataCount: Int { localdata.count(type: RecordItems.self) }
    var recordItems: [RecordItems] {
        var tmpArray: [RecordItems] = []
        localdata.findAll(type: RecordItems.self).forEach {
            tmpArray.append($0)
        }
        return tmpArray
    }

    init() {
        print(localdata.findAll(type: RecordItems.self))
        print(recordItems.count)
    }
}
