//
//  SelectPictureViewController.swift
//  snapChat
//
//  Created by LayYuan on 15/04/2018.
//  Copyright © 2018 justCodeEnterprise. All rights reserved.
//

import UIKit
import FirebaseStorage

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
        
        //DELETE this for production
        messageTextField.text = "test"
        imageAdded = true
        
        if let message = messageTextField.text {
            
            if imageAdded && message != "" {
                //Upload the image
                
                //Make a folder in storage
               let imagesFolder = Storage.storage().reference().child("images")
                
                
                if let image = imageView.image {
                    
                    if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                    
                        let imageRef = imagesFolder.child("\(NSUUID().uuidString).jpg")
                    
                        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                            if let error = error{
                                self.presentAlert(alert: error.localizedDescription)
                            }else{
                                imageRef.downloadURL(completion: { (url, error1) in
                                    if let error1 = error1 {
                                        self.presentAlert(alert: error1.localizedDescription)
                                    }else{
                                        let downloadURL = url?.absoluteString
                                        self.performSegue(withIdentifier: "selectedRecieverSegue", sender: downloadURL)
                                    }
                                })
                            }
                        }
                    }//End imageData
                }
               
            }else {
                //We are missing something
                presentAlert(alert: "You must provide an image and a message for your snap.")

            }
        }
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let downloadURL = sender as? String {
            
            if let selectVC = segue.destination as? SelectRecipientTableViewController {
                selectVC.downloadURL = downloadURL
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

}
