//
//  PostViewController.swift
//  OriginalAPP
//
//  Created by 市川龍星 on 2018/07/13.
//  Copyright © 2018年 市川龍星. All rights reserved.
//

import UIKit

class PostViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var historyTextView: UITextView!
    
    let tweetManager = TweetManager.sharedInstance
    let viewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(PostViewController.tapGesture))
        self.view.addGestureRecognizer(tapRecognizer)
//        nameField.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PostViewController.close))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PostViewController.post))
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func post() {
      
        let tweet = Tweet(nameStr: nameField.text!, tweetImg: myImageView.image!)
        tweet.save()
        self.dismiss(animated: true, completion: nil)
        
        //tweet.image = myImageView.image!
        //        tweet.name = nameField.text!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @objc func tapGesture(_sender: UITapGestureRecognizer) {
        nameField.resignFirstResponder()
        
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
         myImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage

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
