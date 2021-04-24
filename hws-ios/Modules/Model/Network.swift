//
//  Network.swift
//  hws-ios
//
//  Created by 山田楓也 on 2021/04/24.
//

import Apollo
import Foundation

final class Network {
    static let shared = Network()

    private(set) lazy var apollo = ApolloClient(
        url: URL(string: "https://hwsapi.hysrtr.com/query")!
    )
}
