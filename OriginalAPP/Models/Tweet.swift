//
//  Gazo.swift
//  OriginalAPP
//
//  Created by 市川龍星 on 2018/07/13.
//  Copyright © 2018年 市川龍星. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var tweetImage: AnyObject
    var tweetName: String
    
    var user: User?
    
    init(nameStr: String, tweetImg: AnyObject) {
        self.tweetImage = tweetImg
        self.tweetName = nameStr
    }
    
    func ImageChangeString(image:UIImage) -> String {
        
        //画像をNSDataに変換
        let data = UIImagePNGRepresentation(image)! as NSData
        
        let encodeString = data.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithLineFeed)
        //NSDataへの変換が成功していたら
        return encodeString
    }
        
       
    
    
    //StringをUIImageに変換する
    func StringChangeImage(imageString:String) -> UIImage?{

        //空白を+に変換する
//        var base64String = imageString.stringByReplacingOccurrencesOfString(" ", withString:"+",options: nil, range:nil)

        //BASE64の文字列をデコードしてNSDataを生成
        let decodeBase64:NSData? =
            NSData(base64Encoded:imageString, options: .ignoreUnknownCharacters)
        

        //NSDataの生成が成功していたら

        if let decodeSuccess = decodeBase64 {

            //NSDataからUIImageを生成
            let img = UIImage(data: decodeSuccess as Data)

            //結果を返却
            return img
        }

        return nil

    }
    
    func save() {
        let tweetObject = NCMBObject(className: "Tweet")
        tweetObject?.setObject(tweetName, forKey: "name")
        
        let tweetImageString =  self.ImageChangeString(image: tweetImage as! UIImage)
        tweetObject?.setObject(tweetImageString, forKey: "image")
        
        tweetObject?.setObject(NCMBUser.current(), forKey: "user")
        
        tweetObject?.saveInBackground { (error) in
            if error == nil { 
            }
        }
    }

}
