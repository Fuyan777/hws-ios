//
//  SpaceDetailModel.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/17.
//

import Foundation

class SpaceDetailModel {
    var spaceDetail: GetSpacesQuery.Data.Space

    init(spaceDetail: GetSpacesQuery.Data.Space) {
        self.spaceDetail = spaceDetail
    }
}
