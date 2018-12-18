//
//  UserDTO.swift
//  finalProject
//
//  Created by Alberto Leon on 12/15/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class UserDTO {
    
    let userName: String
    let password: String
    let email: String
    var userId: Int
    
    init(userId: Int, userName: String, password: String, email: String) {
        self.userName = userName
        self.password = password
        self.email = email
        self.userId = userId;
    }
    
    init(userName: String, password: String, email: String) {
        self.userName = userName
        self.password = password
        self.userId = 0;
        self.email = ""
    }
    
}
