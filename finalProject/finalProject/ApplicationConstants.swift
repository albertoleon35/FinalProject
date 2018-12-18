//
//  ApplicationConstants.swift
//  finalProject
//
//  Created by Alberto Leon on 12/15/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class ApplicationConstants {
    static let CallOfDutyUri = "https://cod-api.tracker.gg/v1/standard/"
    static fileprivate let Game = "bo4/"
    static fileprivate let Profile = "profile/"

    public static func getUrl(userName: String, platform: String) -> URL? {
        guard let url = URL(string: "\(CallOfDutyUri)\(Game)\(Profile)\(platform)/\(userName)") else {
            return nil
        }
        return url
    }
}
