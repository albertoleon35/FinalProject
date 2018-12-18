//
//  SQLLiteHelper.swift
//  finalProject
//
//  Created by Alberto Leon on 12/15/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation
import SQLite

class SQLLiteHelper  {
    
    public func runStatement(statement: String)  {
        
        guard let dbConnection = openConnectionDatabase() else {
            return
        }
        
        do {
            _ = try dbConnection.run(statement)
            return

        } catch {
             print("Unexpected error: \(error).")
        }
        return
    }
    
    public func runInsertStatement(statement: String) -> SqlLiteMessageDTO {
        
        guard let dbConnection = openConnectionDatabase() else {
            return SqlLiteMessageDTO(success: false, message: "error connecting to sql lite")
        }
        
        do {
            let stmt = try dbConnection.prepare(statement)
            try stmt.run()
        
            return SqlLiteMessageDTO(success: true, message: "Success")
            
        } catch let Result.error(description, code, _) where code == SQLITE_CONSTRAINT {
            return SqlLiteMessageDTO(success: false, message: description)
        } catch {
            return SqlLiteMessageDTO(success: false, message: "error")
        }
    }
    
    public func runSelectStatement(statement: String) -> UserDTO? {
        
        guard let dbConnection = openConnectionDatabase() else {
            return nil
        }
        
        do {
            for row in try dbConnection.prepare(statement) {
                let optionalCount : Int64 = Optional(row[0]) as! Int64
                let userId = Int(optionalCount)
                
                let userName1 : String = Optional(row[1]) as! String
                let userName = String(userName1)
                
                let password1: String = Optional(row[2]) as! String
                let password: String = String(password1)
                
                let email1: String = Optional(row[3]) as! String
                let email: String = String(email1)
                
                return UserDTO(userId: userId, userName: userName, password: password, email: email)
                
            }
        } catch {
            print("Unexpected error: \(error).")
        }
        return nil
    }
    
    public func getPlatformUserByUserId(statement: String) -> [PlatformUserDTO] {
        
        guard let dbConnection = openConnectionDatabase() else {
            return [PlatformUserDTO]()
        }
        
        var platformUsers = [PlatformUserDTO]()
        
        do {
            for row in try dbConnection.prepare(statement) {
                let optionalCount : Int64 = Optional(row[0]) as! Int64
                let userId = Int(optionalCount)
                
                let gamerTag1 : String = Optional(row[1]) as! String
                let gamerTag = String(gamerTag1)
                
                let platform1: String = Optional(row[2]) as! String
                let platform: String = String(platform1)
                
                let user = PlatformUserDTO(userId: userId, gamerTag: gamerTag, platform: platform)
                platformUsers.append(user)
            }

            return platformUsers
            
        } catch {
            print("Unexpected error: \(error).")
        }
        return [PlatformUserDTO]()
    }
    
    
    
    fileprivate func openConnectionDatabase() -> Connection? {
        do {
            let path = "/Users/albertoleon/Documents/"
            let db = try Connection("\(path)/db.sqlite3")
            return db;
        } catch {
            print("Unexpected error: \(error).")
        }
        return nil;
    }
}
