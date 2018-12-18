//
//  RegisterViewController.swift
//  finalProject
//
//  Created by Alberto Leon on 12/16/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailAddressTextbox: UITextField!
    @IBOutlet weak var userNameTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    
    var registerSuccess = false
    var user: UserDTO?
    let toAddPlayersFromRegisterController = "toAddPlayersFromRegisterController"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        
        guard let segueId = identifier else {
            return registerSuccess
        }
        
        if segueId == toAddPlayersFromRegisterController && registerSuccess != true {
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == toAddPlayersFromRegisterController {
            if let playerStatisticsViewController = segue.destination as? PlayerStatisticsViewController {
                playerStatisticsViewController.currentUser = self.user
            }
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        guard let email = emailAddressTextbox.text, let userName = userNameTextBox.text, let password = passwordTextBox.text else {
            return
        }
        
        guard email.contains("@") else {
            displayAlert(messageAlert: "Email Should contain @")
            return
        }
        
        guard userName.count > 5 else {
            displayAlert(messageAlert: "User name should be greater than 5 characters")
            return
        }
        
        guard password.count > 5 else {
            displayAlert(messageAlert: "Password should be greater than 5 characters")
            return
        }
        
        let query = Queries().insertUserQuery(userName: userName.lowercased(), password: password, email: email.lowercased())
        
        let message = SQLLiteHelper().runInsertStatement(statement: query)
        
        guard message.success else {
            displayAlert(messageAlert: message.messgeAdapter())
            return
        }
        
        let userQuery = Queries().getUser(userName: userName.lowercased(), password: password)
        self.user = SQLLiteHelper().runSelectStatement(statement: userQuery)
        registerSuccess = true;
        self.performSegue(withIdentifier: self.toAddPlayersFromRegisterController, sender: self)
    }
    
    fileprivate func displayAlert(messageAlert: String) {
        let alert = UIAlertController(title: "\(messageAlert)", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}
