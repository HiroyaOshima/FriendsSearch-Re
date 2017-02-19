//
//  ViewController.swift
//  FriendsSearch
//
//  Created by 大嶋 広也 on 2017/02/12.
//  Copyright © 2017年 大嶋 広也. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class WelcomeViewController: UIViewController, FBSDKLoginButtonDelegate {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ログインボタンが押された時の処理。Facebookの認証とその結果を取得する
    func loginButton(_ loginButton: FBSDKLoginButton!,didCompleteWith
        result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            //エラー処理
        } else if result.isCancelled {
            //キャンセルされた時
        } else {
            //必要な情報が取れていることを確認(今回はemail必須)
            if result.grantedPermissions.contains("email"){
                // 次の画面に遷移（後で）
                self.performSegue(withIdentifier: "ShowMain", sender: self)
            }
        }
    }
    
    //ログアウトボタンが押された時の処理
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
}

    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil) {
            print("User Already Logged In")
            self.performSegue(withIdentifier: "ShowMain", sender: self)
            //後で既にログインしていた場合の処理（メイン画面へ遷移）を書く
        } else {
            print("User not Logged In")
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
}
}



