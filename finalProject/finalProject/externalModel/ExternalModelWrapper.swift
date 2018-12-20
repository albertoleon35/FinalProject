//
//  ExternalModelWrapper.swift
//  finalProject
//
//  Created by Alberto Leon on 12/19/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class ExternalModelWrapper {
    
    let callOfDuty: CallOfDuty?
    let errorMessage: ErrorMessage?
    
    init(callOfDuty: CallOfDuty?, errorMessage: ErrorMessage?) {
        self.callOfDuty = callOfDuty
        self.errorMessage = errorMessage
    }
}
