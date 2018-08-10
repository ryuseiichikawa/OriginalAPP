//
//  UserDB.swift
//  OriginalAPP
//
//  Created by 市川龍星 on 2018/07/30.
//  Copyright © 2018年 市川龍星. All rights reserved.
//

import UIKit

class UserDB: NSObject {
    var aboutUser: String
    var profileImage : AnyObject
    
    var user: User?
    
    init(aboutUs: String, profileImg: AnyObject) {
         self.aboutUser = aboutUs
         self.profileImage = profileImg
    }
    
    func ImageChangeString(image:UIImage) -> String {
        let data = UIImagePNGRepresentation(image)! as NSData
        
        let encodeString = data.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithLineFeed)
        //NSDataへの変換が成功していたら
        return encodeString
    }
    
    func StringChangeImage(imageString:String) -> UIImage? {
        let decodeBase64:NSData? =
            NSData(base64Encoded:imageString, options: .ignoreUnknownCharacters)
        
        if let decodeSuccess = decodeBase64 {
            
            //NSDataからUIImageを生成
            let img = UIImage(data: decodeSuccess as Data)
            
            //結果を返却
            return img
        }
        
        return nil

        
        
    }
    
    
    
    func save() {
        let userObject = NCMBObject(className: "UserDB")
        userObject?.setObject(aboutUser, forKey: "selfIntroduction")
        
        let profileImageString = self.ImageChangeString(image: profileImage as! UIImage)
        userObject?.setObject(profileImageString, forKey: "profileImage")
        
        userObject?.setObject(NCMBUser.current(), forKey: "user")
        
        print(NCMBUser.current().userName)
        
        userObject?.saveInBackground { (error) in
            if error == nil {
            }
        }

    }
    

}
