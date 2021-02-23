//
//  LoggingUser.swift
//  Busyness!
//
//  Created by Carlos Morales III on 12/5/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import Foundation

class LoggingUser: Codable {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
