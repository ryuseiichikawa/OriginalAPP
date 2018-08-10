//
//  DetailViewController.swift
//  OriginalAPP
//
//  Created by 市川龍星 on 2018/07/10.
//  Copyright © 2018年 市川龍星. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameBtn: UIButton!
    @IBOutlet weak var userNameBtn: UIButton!
    
    
    
    var tweets: [Tweet] = []
    
    
    var selectedImg: UIImage!
    var selectedName: String!
    var selectedUserName: String!
    var selectedAboutUser: String!

    let userDBManager = UserDBManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        detailTableView.delegate = self
//        detailTableView.dataSource = self
        
    }

//    @IBAction func userNameBtnAction(_ sender: UIButton) {
//        performSegue(withIdentifier: "toProfileSegue", sender: nil)
//
//        userDBManager.fetchUserDBs{ () in
//
//        }
//    }
//
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        self.title = "詳細画面"
        
        

//タイムラインのセル情報を表示
        selectedImg = tweets[0].StringChangeImage(imageString: self.tweets[0].tweetImage as! String)
        detailImageView.image = selectedImg
        
        selectedName = tweets[0].tweetName
        self.nameBtn.setTitle(selectedName, for: UIControlState.normal)
        
        selectedUserName = tweets[0].user?.userName
        self.userNameBtn.setTitle(selectedUserName, for: UIControlState.normal)
        
//        selectedAboutUser =
    }
    
    @IBAction func userBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "toProfileSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfileSegue" {
            let profileViewController = segue.destination as! ProfileViewController
            profileViewController.tweets = [self.tweets[0]]
            
        }
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
