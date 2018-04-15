//
//  ViewController.swift
//  snapChat
//
//  Created by LayYuan on 14/04/2018.
//  Copyright © 2018 justCodeEnterprise. All rights reserved.
//

//TODO -
//20180414 : 1.Add phone sign in

import UIKit
import FirebaseAuth

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
        
        if let email = emailTextField.text {
            if let password = passwordTextField.text{
                
                if signUpMode{
                    //For Sign Up
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        if let error = error {
                            //print(error.localizedDescription)
                            self.presentAlert(alert: error.localizedDescription)
                        }else {
                            print("Sign Up was successful")
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                        }
                    }
                    
                }else {
                    //For Log IN
                    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                        if let error = error{
                            //print(error.localizedDescription)
                            self.presentAlert(alert: error.localizedDescription)
                        }else{
                            print("Log In was successful")
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)

                        }
                    }
                    
                    
                    
                }
            }
        }
        
    
    }
    
    func presentAlert(alert: String){
        
       let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
        
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

