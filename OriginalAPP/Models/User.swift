//
//  User.swift
//  OriginalAPP
//
//  Created by 市川龍星 on 2018/07/26.
//  Copyright © 2018年 市川龍星. All rights reserved.
//

import UIKit

class User: NSObject {
    var userName: String
    var password: String
    
    
    init(userNm: String, passWd: String) {
        self.userName = userNm
        self.password = passWd
       
    }
    
    func signUp(callback: @escaping (_ message: String?) -> Void ) {
        let user = NCMBUser()
        user.userName = userName
        user.password = password
        user.signUpInBackground { (error) in
            let nserror = error as NSError?
            callback(_: nserror?.userInfo["NSLocalizedDescription"] as? String)
            
        }
    }

    func login(callback: @escaping (_ message: String?) -> Void){
        NCMBUser.logInWithUsername(inBackground: self.userName, password: self.password) {(user, error) in
            let nserror = error as NSError?
            callback(_: nserror?.userInfo["NSLoclizedDescription"] as? String)
        }
    }
    
    
    
}
