//
//  ViewController.swift
//  snapChat
//
//  Created by LayYuan on 14/04/2018.
//  Copyright © 2018 justCodeEnterprise. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var signUpMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   
    @IBAction func topTapped(_ sender: Any) {
    }
    
    @IBAction func bottomTapped(_ sender: Any) {
        
        if signUpMode{
            
            //switch to login
            signUpMode = false
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
            
        }else{
            
            //switch to signUp
            signUpMode = true
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
            
        }
    }
    
}

