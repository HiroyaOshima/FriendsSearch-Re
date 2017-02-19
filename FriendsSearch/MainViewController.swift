//
//  MainViewController.swift
//  FriendsSearch
//
//  Created by 大嶋 広也 on 2017/02/19.
//  Copyright © 2017年 大嶋 広也. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class MainViewController:UIViewController{
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var currentuserName: UILabel!
    
    var userProfile:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnUserData()
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me",
                                                                 parameters: ["fields": "id, name, first_name, last_name, picture.type(large)"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil)
            {
                // エラー処理
                print("Error: \(error)")
            }
            else
            {
                // プロフィール情報をディクショナリに入れる
                self.userProfile = result as! NSDictionary
                print(self.userProfile)
                
                // プロフィール画像の取得（よくあるように角を丸くする）
                let profileImageURL : String = ((self.userProfile.object(forKey: "picture") as AnyObject).object(forKey: "data") as AnyObject).object("url") as! String
                var profileImage = UIImage(data: NSData(contentsOf: NSURL(string: profileImageURL)! as URL)! as Data)
                self.userImage.clipsToBounds = true
                self.userImage.layer.cornerRadius = 60
                self.userImage.image = self.trimPicture(rawPic: profileImage!)
                
                //名前とemail
                
                self.currentuserName.text = self.userProfile.object(forKey: "name") as? String
                
            }
        })
        
    }
    func trimPicture(rawPic:UIImage) -> UIImage {
        var rawImageW = rawPic.size.width
        var rawImageH = rawPic.size.height
        
        var posX = (rawImageW - 200) / 2
        var posY = (rawImageH - 200) / 2
        var trimArea : CGRect = CGRectMake(posX, posY, 200, 200)
        
        var rawImageRef:CGImage = rawPic.cgImage!
        var trimmedImageRef = rawImageRef.cropping(to: trimArea)
        var trimmedImage : UIImage = UIImage(cgImage : trimmedImageRef!)
        return trimmedImage
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
 
    
}
