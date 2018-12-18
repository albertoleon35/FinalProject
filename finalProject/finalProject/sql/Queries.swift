//
//  SqlLiteHelper.swift
//  finalProject
//
//  Created by Alberto Leon on 12/15/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class Queries {
    
    let createUserTableQuery = "CREATE TABLE IF NOT EXISTS user (userId INTEGER PRIMARY KEY AUTOINCREMENT,userName TEXT NOT NULL UNIQUE,password TEXT NOT NULL, email TEXT NOT NULL UNIQUE);"
    
    let createplatformUserQuery = "CREATE TABLE IF NOT EXISTS platformUser (userId INTEGER, gamerTag TEXT NOT NULL, platform TEXT NOT NULL, PRIMARY KEY (userId, gamerTag),FOREIGN KEY (userId) REFERENCES contacts (userId)ON DELETE CASCADE ON UPDATE NO ACTION);"
    
    public func insertUserQuery(userName: String, password: String, email: String) -> String {
        return "INSERT INTO user (userName, password, email) VALUES (\"\(userName)\", \"\(password)\", \"\(email)\");"
    }
    
    public func insertFollowedUserQuery(userId: String, gamerTag: String, platform: String) -> String {
        return "INSERT INTO platformUser (userId, gamertag, platform) VALUES (\"\(userId)\", \"\(gamerTag)\", \"\(platform)\");"
    }
    
    public func getUser(userName: String, password: String) -> String {
        return "SELECT userId, userName, password, email FROM user WHERE userName = \"\(userName)\" AND password = \"\(password)\";"
    }
    
}
