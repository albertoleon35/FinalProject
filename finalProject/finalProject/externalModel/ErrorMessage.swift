//
//  ErrorMessage.swift
//  finalProject
//
//  Created by Alberto Leon on 12/19/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class ErrorMessage : Codable {
    let errors: [Error]?
    
    init(errors: [Error]?) {
        self.errors = errors
    }
}

class Error : Codable {
    let message: String?
    
    init(message: String?) {
        self.message = message
    }
}
