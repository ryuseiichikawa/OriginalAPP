//
//  ProfileViewController.swift
//  OriginalAPP
//
//  Created by 市川龍星 on 2018/07/11.
//  Copyright © 2018年 市川龍星. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let detailViewController = DetailViewController()
    @IBOutlet weak var userNameLabelOfProfile: UILabel!
    @IBOutlet weak var aboutUserTextViewOfProfile: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var text: String!
    
    var tweets: [Tweet] = []
    
    let userDBManager = UserDBManager()
    
    let userDBModel = UserDB(aboutUs: "", profileImg: UIImage() )

    
    override func viewDidLoad() {
        super.viewDidLoad()

    // Do any additional setup after loading the view.
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)

        self.userNameLabelOfProfile.text = self.tweets[0].user?.userName
        
        userDBManager.fetchUserDBs {
            
            for userDBItem in self.userDBManager.userDBs {
                if userDBItem.user?.userName == self.tweets[0].user?.userName{
                    
                    self.aboutUserTextViewOfProfile.text = userDBItem.aboutUser
                    
                    let image = self.userDBModel.StringChangeImage(imageString: userDBItem.profileImage as! String)
                    self.profileImageView.image = image
                }
            }
            
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

