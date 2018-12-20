//
//  CallOfDutyExternalModel.swift
//  finalProject
//
//  Created by Alberto Leon on 12/18/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class CallOfDuty : Codable {
    let data: DataClass?
    
    init(data: DataClass?) {
        self.data = data
    }
}

class DataClass : Codable {
    let id, type: String?
    let metadata: DataMetadata?
    let stats: [Stat]?
    
    init(id: String?, type: String?, metadata: DataMetadata?, stats: [Stat]?) {
        self.id = id
        self.type = type
        self.metadata = metadata
        self.stats = stats
    }
}

class DataMetadata : Codable {
    let statsCategoryOrder: [String]?
    let platformID: Int?
    let platformUserHandle, accountID, cacheExpireDate: String?
    
    init(statsCategoryOrder: [String]?, platformID: Int?, platformUserHandle: String?, accountID: String?, cacheExpireDate: String?) {
        self.statsCategoryOrder = statsCategoryOrder
        self.platformID = platformID
        self.platformUserHandle = platformUserHandle
        self.accountID = accountID
        self.cacheExpireDate = cacheExpireDate
    }
}


class Stat : Codable {
    let metadata: StatMetadata?
    let value: Double?
    let percentile: Int?
    let displayValue, displayRank: String?
    
    init(metadata: StatMetadata?, value: Double?, percentile: Int?, displayValue: String?, displayRank: String?) {
        self.metadata = metadata
        self.value = value
        self.percentile = percentile
        self.displayValue = displayValue
        self.displayRank = displayRank
    }
}

class StatMetadata : Codable {
    let key, name: String?
    let categoryKey: String?
    let categoryName: String?
    let isReversed: Bool?
    let iconURL: String?
    
    init(key: String?, name: String?, categoryKey: String?, categoryName: String?, isReversed: Bool?, iconURL: String?) {
        self.key = key
        self.name = name
        self.categoryKey = categoryKey
        self.categoryName = categoryName
        self.isReversed = isReversed
        self.iconURL = iconURL
    }
}
