//
//  LoginViewController.swift
//  OriginalAPP
//
//  Created by 市川龍星 on 2018/07/26.
//  Copyright © 2018年 市川龍星. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var aboutUserTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        let user = User(userNm: userNameTextField.text!, passWd: passwordTextField.text!)
        user.login { (message) in
            if let unwrappedMessage = message {
                self.showAlert(message: unwrappedMessage)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func tapSignUpButton(_ sender: UIButton) {
        let user = User(userNm: userNameTextField.text!, passWd: passwordTextField.text!)
//        let userDB = UserDB(aboutUs: aboutUserTextView.text!, profileImg: UIImage())
//        
        user.signUp { (message) in
            if let unwrappedMessage = message {
                self.showAlert(message: unwrappedMessage)
                print("サインアップ失敗")
            }else {
//                self.dismiss(animated: true, completion: nil)
                let userDB = UserDB(aboutUs: self.aboutUserTextView.text!, profileImg: self.userImage.image!)
                userDB.save()
                print("サインアップ成功")
            }
        }
        
        
        
        self.dismiss(animated: true, completion: nil)

        
    }
    
    func showAlert(message: String?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func tapAlbumButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let album = UIImagePickerController()
            album.sourceType = UIImagePickerControllerSourceType.photoLibrary
            album.delegate = self
            album.allowsEditing = true
            self.present(album, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func tapPhotoButton(_ sender: UIButton) {
        if
            UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let camera = UIImagePickerController()
            camera.sourceType = UIImagePickerControllerSourceType.camera
            camera.delegate = self
            camera.allowsEditing = true
            self.present(camera, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        userImage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
