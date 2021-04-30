//
//  LoginViewController.swift
//  sidedishApp
//
//  Created by zombietux on 2021/04/29.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.value(forKey: TokenManager.key) == nil {
            logoutButton.isHidden = true
        } else {
            loginButton.isHidden = true
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        TokenManager.delete()
        loginButton.isHidden = false
        logoutButton.isHidden = true
    }
}
