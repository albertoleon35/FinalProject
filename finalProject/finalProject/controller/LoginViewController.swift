//
//  ViewController.swift
//  finalProject
//
//  Created by Alberto Leon on 12/10/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var loginSuccess = false
    let toAddPlayersFromLoginController = "toAddPlayersFromLoginController"
    let unwindToLoginControllerFromPlayerStatisticsController = "unwindToLoginControllerFromPlayerStatisticsController"
    let unwindToLoginPageFromRegisterController = "unwindToLoginPageFromRegisterController"
    var user: UserDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadeToWidget(widget: userNameTextBox)
        addShadeToWidget(widget: passwordTextBox)
        addShadeToWidget(widget: registerButton)
        addShadeToWidget(widget: loginButton)
        // Do any additional setup after loading the view, typically from a nib.
        SQLLiteHelper().runStatement(statement: Queries().createUserTableQuery)
        SQLLiteHelper().runStatement(statement: Queries().createplatformUserQuery)
        
    }
    
    @IBAction func unwindToLoginController(segue:UIStoryboardSegue) {
        guard let identifier = segue.identifier else {
            return
        }
        
        if (identifier == unwindToLoginControllerFromPlayerStatisticsController || identifier == unwindToLoginPageFromRegisterController) {
            userNameTextBox.text = ""
            passwordTextBox.text = ""
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        
        guard let segueId = identifier else {
            return false
        }
        
        if segueId == toAddPlayersFromLoginController && loginSuccess != true {
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == toAddPlayersFromLoginController {
            if let playerStatisticsViewController = segue.destination as? PlayerStatisticsViewController {
                playerStatisticsViewController.currentUser = self.user
            }
        }
    }
    

    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let userName = userNameTextBox.text, let password = passwordTextBox.text, !userName.isEmpty &&  !password.isEmpty else {
            displayAlert(messageAlert: "Please fill both User Name and Password fields")
            return;
        }
        
        let statement = Queries().getUser(userName: userName.lowercased(), password: password.lowercased())
       
        guard let user = SQLLiteHelper().runSelectStatement(statement: statement) else {
            displayAlert(messageAlert: "User name or Password does not match our records")
            return;
        }
        self.user = user;
        loginSuccess = true
    }
    
    fileprivate func addShadeToWidget(widget: UIControl) {
        widget.layer.shadowColor = UIColor.black.cgColor
        widget.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        widget.layer.shadowRadius = 2.0
        widget.layer.shadowOpacity = 0.5
        widget.layer.masksToBounds = false
    }
    
    fileprivate func displayAlert(messageAlert: String) {
        let alert = UIAlertController(title: "\(messageAlert)", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}

