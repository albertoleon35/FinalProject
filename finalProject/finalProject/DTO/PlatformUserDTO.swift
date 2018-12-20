//
//  PlatformUserDTO.swift
//  finalProject
//
//  Created by Alberto Leon on 12/17/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class PlatformUserDTO {
    
    let userId: Int
    let gamerTag: String
    let platform: String
    var callOfDuty: CallOfDuty?
    var errorMessage: ErrorMessage?
    
    init(userId: Int, gamerTag: String, platform: String) {
        self.userId = userId
        self.gamerTag = gamerTag
        self.platform = platform
    }
    
    
}
