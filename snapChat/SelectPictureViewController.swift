//
//  SelectPictureViewController.swift
//  snapChat
//
//  Created by LayYuan on 15/04/2018.
//  Copyright © 2018 justCodeEnterprise. All rights reserved.
//

import UIKit

class SelectPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var imagePicker : UIImagePickerController?
    var imageAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        
    }

 
    @IBAction func selectPhotoTapped(_ sender: Any) {
        if imagePicker != nil {
            imagePicker!.sourceType = .photoLibrary
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        if imagePicker != nil {
            imagePicker!.sourceType = .camera
            present(imagePicker!, animated: true, completion: nil)
        }

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageAdded = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func NextTapped(_ sender: Any) {
        
        if let message = messageTextField.text {
            
            if imageAdded && message != "" {
                //segue to next view controller
            }else {
                //We are missing something
                let alertVC = UIAlertController(title: "Error", message: "You must provide an image and a message for your snap.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertVC.dismiss(animated: true, completion: nil)
                }
                
                alertVC.addAction(okAction)
                present(alertVC, animated: true, completion: nil)
                

            }
        }
      
    }
}
