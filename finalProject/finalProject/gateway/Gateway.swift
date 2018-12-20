//
//  Gateway.swift
//  finalProject
//
//  Created by Alberto Leon on 12/18/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation
import Alamofire

class Gateway {

    
    public func getPlayerStats(player: PlatformUserDTO, completionHandler: @escaping (ExternalModelWrapper?) -> ()) {
        self.getDetailedPlayerStats(player: player, completionHandler: completionHandler)
    }
    
    fileprivate func getDetailedPlayerStats(player: PlatformUserDTO, completionHandler: @escaping  (ExternalModelWrapper?) -> ()) {
        guard let url = createGetUrl(player: player) else {
            return
        }
        
        var otherRequest = URLRequest(url: url)
        otherRequest.httpMethod = HTTPMethod.get.rawValue
        otherRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(otherRequest).responseData { (response: DataResponse<Data>) in
            
            if response.response?.statusCode == 404 {
                if let jsonData = response.result.value {
                    let jsonDecoder = JSONDecoder()
                    
                    do {
                        let model = try jsonDecoder.decode(ErrorMessage.self, from: jsonData)
                        let externalModelWrapper = ExternalModelWrapper(callOfDuty: nil, errorMessage: model)
                        completionHandler(externalModelWrapper)
                    } catch {
                        print("Unexpected error: \(error).")
                    }
                }
            } else {
                if let jsonData = response.result.value {
                    let jsonDecoder = JSONDecoder()
                    
                    do {
                        let model = try jsonDecoder.decode(CallOfDuty.self, from: jsonData)
                        let externalModelWrapper = ExternalModelWrapper(callOfDuty: model, errorMessage: nil)
                        completionHandler(externalModelWrapper)
                    } catch {
                        print("Unexpected error: \(error).")
                    }
                }
            }
        }
    }
    
    fileprivate func createGetUrl(player: PlatformUserDTO) -> URL? {
//        https://cod-api.tracker.gg/v1/standard/bo4/profile/2/ALo0N5o0o
       
        guard let platform = PlatformDictionary.Platform[player.platform] else {
            return nil
        }
        guard let url = ApplicationConstants.getUrl(userName: player.gamerTag, platform: platform) else {
            return nil
        }
        
        return url
    }
}
