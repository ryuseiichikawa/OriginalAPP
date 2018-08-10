//
//  ViewController.swift
//  OriginalAPP
//
//  Created by 市川龍星 on 2018/07/07.
//  Copyright © 2018年 市川龍星. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    let tweetManager = TweetManager()
    let tweetModel = Tweet(nameStr: "", tweetImg: UIImage())
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
//        セルの登録
        myTableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCell")


        
    }

//   セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
        return tweetManager.tweets.count
    }
    
// せる内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath)as! SecondTableViewCell
        let tweet = tweetManager.tweets[indexPath.row]
        let image = tweetModel.StringChangeImage(imageString: tweet.tweetImage as! String)
        cell.tweetImageView.image = image
        cell.tweetNameLabel!.text = tweet.tweetName
        cell.userNameLabel!.text = tweet.user?.userName
        return cell
    }
    

    
    //Rowの高さの設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "穴場"
    }
    
//詳細画面に遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SecondSegue", sender: tweetManager.tweets[indexPath.row])
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "SecondSegue" {
        
                    let detailViewController = segue.destination as! DetailViewController
        
                    print("\(sender as! Tweet)" + "AAAAAAAAAAAA")
        
                    detailViewController.tweets.append(sender as! Tweet )
                    
                    
                    
//                    print(detailViewController.tweets[0].tweetImage)
//                    print(detailViewController.tweets[0].tweetName)
        
                }
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "SecondSegue" {
//
//            let detailViewController = segue.destination as! DetailViewController
//
//            print("\(sender as! Tweet)" + "AAAAAAAAAAAA")
//
//            detailViewController.tweets.append(sender as! Tweet) //= sender as! [Tweet]
//            tweets[0].StringChangeImage(imageString: self.tweets[0].tweetImage as! String)
//            print(detailViewController.tweets[0].tweetImage)
//            print(detailViewController.tweets[0].tweetName)
//
//        }

        
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "タイムライン"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "投稿", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.toPostViewController(sender:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.logout))
       
        tweetManager.fetchTweets{ () in
            self.myTableView.reloadData()
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if NCMBUser.current() == nil{
            performSegue(withIdentifier: "toLoginViewController", sender: self)
        }
    }

    @objc func toPostViewController(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "PostSegue", sender: nil)
    }
    
    @objc func logout() {
        NCMBUser.logOut()
        performSegue(withIdentifier: "toLoginViewController", sender: self)
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
////        ここにindexPathを利用した画面遷移の処理を書く
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


}



