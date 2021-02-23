//
//  decodableRequest.swift
//  Busyness!
//
//  Created by Carlos Morales III on 12/12/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import Foundation

struct decoableRequest: Decodable {
    let body: String
    let priority: Int
    let timeCreated: Date
    let title: String
}
