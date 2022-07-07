//
//  LeftVC.swift
//  EgyStore
//
//  Created by Macbook on 11/15/20.
//  Copyright © 2020 Abdallah Eslah. All rights reserved.
//

import UIKit

class MenuVC: UITableViewController {

    @IBOutlet weak var avaImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var changeLangButton: UISwitch!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(named:"MainColor")
        getUserData()
        tableView.tableFooterView = UIView()
        
    }
 
    func getUserData() {
       
        self.avaImage.layer.borderWidth = 1.0
        self.avaImage.layer.borderColor = UIColor(named: "TextColor")?.cgColor
        
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "CustomerLogout" {
                   
            /* Logout & Delete User Data
            // refresh the view to remove continue with your email from LoginVC to force go back to it ******/
//            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
//            let vc = storyboard.instantiateViewController(identifier: "LoginVC") as! LoginVC
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window!.rootViewController = vc
                    
            return false
        }
        return true
    }
    
    
    @IBAction func changeLangButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func termsOfUserDidTapped(_ sender: Any) {
        
        guard let settingsUrl = URL(string:"https://sites.google.com/view/akalatshoptermsof-use/home") else {
            return
        }
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    
    @IBAction func privacyPolicyDidTapped(_ sender: Any) {
        guard let settingsUrl = URL(string:"https://sites.google.com/view/akalatshopprivacypolicy/home") else {
            return
        }
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    
}

