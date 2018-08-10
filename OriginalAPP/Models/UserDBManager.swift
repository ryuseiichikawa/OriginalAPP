//
//  UserDBManager.swift
//  OriginalAPP
//
//  Created by 市川龍星 on 2018/07/30.
//  Copyright © 2018年 市川龍星. All rights reserved.
//

import UIKit

class UserDBManager: NSObject {
    static let sharedInstance = UserDBManager()
    var userDBs: [UserDB] = []
    
    var user: User?
    
    func fetchUserDBs(callback: @escaping () -> Void) {
        let query = NCMBQuery(className: "UserDB")
        query?.includeKey("user")
        query?.order(byDescending: "createDate")
        query?.findObjectsInBackground { (objects, error) in
            if error == nil {
                self.userDBs = []
                for object in objects! {
                    let selfIntroduction = (object as AnyObject).object(forKey: "selfIntroduction") as! String
                    let profileImage = (object as AnyObject).object(forKey: "profileImage") as AnyObject
                    let userDB = UserDB(aboutUs: selfIntroduction, profileImg: profileImage)
                    
                    let userObject = (object as AnyObject).object(forKey: "user") as! NCMBUser
                    print(userObject.userName!)
                    let user = User(userNm: userObject.userName, passWd: "")
                    userDB.user = user
                    
                    self.userDBs.append(userDB)
                    callback()
                    
                    
                }
            }
            
        }
    }

}
