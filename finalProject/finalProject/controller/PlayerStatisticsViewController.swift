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
    
    
    @IBOutlet weak var followPlayerButton: UIButton!
    @IBOutlet weak var showStatsButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    let platform = ["Playstation 4", "Xbox", "PC"]
    
    var followedUsers = [PlatformUserDTO]()
    var currentUser: UserDTO?
    var playerPlatform: String = "Playstation 4"
    var continueToDetailedPlayerStats = false
    var toDetailPlayerStatisticsController = "toDetailPlayerStatisticsController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadeToWidget(widget: gamerIDTextBox)
        addShadesToPickers(widget: platformPicker)
        addShadesToPickers(widget: followedUsersPicker)
        addShadeToWidget(widget: followPlayerButton)
        addShadeToWidget(widget: showStatsButton)
        addShadeToWidget(widget: logoutButton)
        
        retrievePlayersFollowByUser()
        setupPickers();
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        
        guard let segueId = identifier else {
            return false
        }
        
        if segueId == self.toDetailPlayerStatisticsController && self.continueToDetailedPlayerStats != true {
            return false
        }
        
        return true
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.toDetailPlayerStatisticsController {
            if let detailedPlayerStatsController = segue.destination as? DetailedPlayerStatisticsCollectionViewController {
                detailedPlayerStatsController.currentUser = self.currentUser
                detailedPlayerStatsController.followedUsers = self.followedUsers
                
            }
        }
     }
    
    @IBAction func unwindToPlayerStatistics(segue:UIStoryboardSegue) {}
    
    @IBAction func showStatsButtonPressed(_ sender: Any) {
        guard self.followedUsers.count > 0 else {
            self.displayAlert(messageAlert: "Please follow at least one gamer")
            return
        }
        continueToDetailedPlayerStats = true
        self.performSegue(withIdentifier: self.toDetailPlayerStatisticsController, sender: self)
    }
    
    @IBAction func followPlayerButtonPressed(_ sender: Any) {
        guard let currentUser = self.currentUser else {
            return
        }
        
        guard let gamerTag = gamerIDTextBox.text else {
            return
        }
        
        guard gamerTag.count > 0 else {
            self.displayAlert(messageAlert: "Please provide a gamer tag")
            return
        }
        
        let insertQuery = Queries().insertFollowedUserQuery(userId: "\(currentUser.userId)", gamerTag: gamerTag, platform: playerPlatform)
        
        let success = SQLLiteHelper().runInsertStatement(statement: insertQuery)
        
        if success.success {
            
            guard let userId = self.currentUser?.userId else {
                self.displayAlert(messageAlert: "Something bad happened")
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
    
    fileprivate func displayAlert(messageAlert: String) {
        let alert = UIAlertController(title: "\(messageAlert)", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
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
    
    fileprivate func addShadesToPickers(widget: UIPickerView) {
       widget.layer.shadowColor = UIColor.black.cgColor
       widget.layer.shadowOffset = CGSize(width: 0, height: 2.0)
       widget.layer.shadowRadius = 2.0
       widget.layer.shadowOpacity = 0.5
       widget.layer.masksToBounds = false
    }
    
    fileprivate func addShadeToWidget(widget: UIControl) {
        widget.layer.shadowColor = UIColor.black.cgColor
        widget.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        widget.layer.shadowRadius = 2.0
        widget.layer.shadowOpacity = 0.5
        widget.layer.masksToBounds = false
    }
    


}
