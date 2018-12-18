//
//  SqlLiteMessageDTO.swift
//  finalProject
//
//  Created by Alberto Leon on 12/16/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class SqlLiteMessageDTO {
    let success: Bool
    var message: String
    
    init(success: Bool, message: String) {
        self.success = success
        self.message = message
    }
    
    public func messgeAdapter() -> String {
        if success == false {
            if message.lowercased().contains("userName") {
                return "User name already exists"
            }
            else if message.lowercased().contains("email") {
                return "Email address already exisits"
            }
        }
        
        return self.message
    }
}
