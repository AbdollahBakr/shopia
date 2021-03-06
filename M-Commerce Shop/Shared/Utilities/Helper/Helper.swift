//
//  Helper.swift
//  SportsApp
//
//  Created by Macbook on 06/06/2022.
//

import Foundation
import UIKit
import SwiftMessages
import ProgressHUD

class Helper {
    
    static var userDefault = UserDefaults()
    
    static func displayMessage(message: String, messageError: Bool) {
        DispatchQueue.main.async {
            
           let view = MessageView.viewFromNib(layout: MessageView.Layout.messageView)
           if messageError == true {
               view.configureTheme(.error)
           } else {
               view.configureTheme(.success)
           }
           
           view.iconImageView?.isHidden = true
           view.iconLabel?.isHidden = true
           view.titleLabel?.isHidden = true
           view.bodyLabel?.text = message
           view.bodyLabel?.textAlignment = .center
           view.bodyLabel?.font = UIFont.systemFont(ofSize: 22.0)
           view.titleLabel?.textColor = UIColor.white
           view.bodyLabel?.textColor = UIColor.white
           view.button?.isHidden = true
           
           var config = SwiftMessages.Config()
           config.presentationStyle = .bottom
           SwiftMessages.show(config: config, view: view)
       }
    }
    
    static func hudProgress() {
        ProgressHUD.show("Loading...")
        ProgressHUD.animationType   = .circleSpinFade
        ProgressHUD.colorAnimation  = CustomColors.MainColor
        ProgressHUD.colorHUD        = .label
    }
    
    static func dismissHud() {
        ProgressHUD.dismiss()
    }
    
    static func showAnimation() {
        AnimationLottie.splashScreen.play()
        AnimationLottie.splashScreen.loopMode = .loop
        AnimationLottie.splashScreen.animationSpeed = 1
    }
    
    static func dismissAnimation() {
        AnimationLottie.splashScreen.stop()
        AnimationLottie.splashScreen.alpha = 0
    }
    
    static func saveUserLogin (userId: Int){
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
    static func isUserLoggedIn() -> Bool{
        
        if (userDefault.integer(forKey: "userId") != 0) {
            return true
        }else{
            return false
        }
    }
    
    static func logoutUser (){
        userDefault.removeObject(forKey: "userId")
    }
    
}


extension UIViewController {
    
    func showVC(storyboardName:String,identifier:String) {
        let newVC = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(identifier: identifier)
        navigationController?.show(newVC, sender: self)
    }
    
    func presentVC(vc:UIViewController,animated:Bool) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: animated)
    }
    
    func pushVC(storyboardName:String,identifier:String,animated:Bool) {
        let newVC = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(identifier: identifier)
        //presenting accessed viewController
        navigationController?.pushViewController(newVC, animated: animated)
        
    }
}
