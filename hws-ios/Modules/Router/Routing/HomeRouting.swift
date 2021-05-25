//
//  HomeRouting.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/17.
//

import Foundation

protocol HomeRouting: AnyObject {
    func pushSpaceDetail(spaceData: GetSpacesQuery.Data.Space)
}
