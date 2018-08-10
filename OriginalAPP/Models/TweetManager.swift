//
//  TweetManager.swift
//  OriginalAPP
//
//  Created by 市川龍星 on 2018/07/19.
//  Copyright © 2018年 市川龍星. All rights reserved.
//

import UIKit

class TweetManager: NSObject {
    static let sharedInstance = TweetManager()
    var tweets: [Tweet] = []
    
    func fetchTweets(callback: @escaping () -> Void) {
        let query = NCMBQuery(className: "Tweet")
        
         query?.includeKey("user")
         query?.order(byDescending: "createDate")
        query?.findObjectsInBackground { (objects, error) in
            if error == nil {
                self.tweets = []
                for object in objects! {
                    let name = (object as AnyObject).object(forKey: "name") as! String
                    let image = (object as AnyObject).object(forKey: "image") as AnyObject
                    let tweet = Tweet(nameStr: name, tweetImg: image)
                    
                    let userObject = (object as AnyObject).object(forKey: "user") as! NCMBUser
                    print(userObject.userName!)
                    let user = User(userNm: userObject.userName, passWd: "")
                    tweet.user = user
                    
                    self.tweets.append(tweet)
                    callback()
                    
                }
            }
        }
    }
    




}
