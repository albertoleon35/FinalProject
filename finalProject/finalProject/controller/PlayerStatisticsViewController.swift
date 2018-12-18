//
//  PlayerStatitisticsViewController.swift
//  finalProject
//
//  Created by Alberto Leon on 12/16/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import UIKit

class PlayerStatisticsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var gamerIDTextBox: UITextField!
    @IBOutlet weak var platformPicker: UIPickerView!
    @IBOutlet weak var followedUsersPicker: UIPickerView!
    
    let platform = ["Playstation 4", "Xbox", "PC"]
    var followedUsers = [PlatformUserDTO]()
    
    var currentUser: UserDTO?
    var playerPlatform: String = "Playstation 4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrievePlayersFollowByUser()
        setupPickers();
    }
    
    @IBAction func followPlayerButtonPressed(_ sender: Any) {
        guard let currentUser = self.currentUser else {
            return
        }
        
        guard let gamerTag = gamerIDTextBox.text else {
            return
        }
        
        let insertQuery = Queries().insertFollowedUserQuery(userId: "\(currentUser.userId)", gamerTag: gamerTag, platform: playerPlatform)
        
        let success = SQLLiteHelper().runInsertStatement(statement: insertQuery)
        
        if success.success {
            
            guard let userId = self.currentUser?.userId else {
                return
            }
            
            let query = Queries().getFollowedUserByUserId(userId: userId)
            self.followedUsers = SQLLiteHelper().getPlatformUserByUserId(statement: query)
            followedUsersPicker.reloadAllComponents()
            self.gamerIDTextBox.text = ""
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == platformPicker {
            return platform.count
        } else if pickerView == followedUsersPicker {
            return followedUsers.count
        }
        return 0

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == platformPicker {
            return platform[row]
        } else if pickerView == followedUsersPicker {
            
            if followedUsers.count > 0 {
                return "\(followedUsers[row].gamerTag), \(followedUsers[row].platform)"
            }
            return ""
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == platformPicker {
            switch row {
            case 0:
                self.playerPlatform = platform[row]
            case 1:
                self.playerPlatform = platform[row]
            case 2:
                self.playerPlatform = platform[row]
            default:
                self.playerPlatform = platform[0]
            }
        }
    }
    
    fileprivate func retrievePlayersFollowByUser() {
        guard let user = currentUser else {
            return
        }
        let query = Queries().getFollowedUserByUserId(userId: user.userId)
        self.followedUsers = SQLLiteHelper().getPlatformUserByUserId(statement: query)
    }
    
    fileprivate func setupPickers() {
        self.platformPicker.delegate = self
        self.platformPicker.dataSource = self
        
        self.followedUsersPicker.delegate = self
        self.followedUsersPicker.dataSource = self
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
