//
//  HomeVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 26/06/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var navBarItems: [UIBarButtonItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        for barButtonItem in navBarItems {
//            barButtonItem.la
//            barButtonItem.backgroundColor = UIColor.lightGray
//        }
        recurseViews(view: navigationController!.navigationBar)
    }
    
    func recurseViews(view:UIView) {
        print("recurseViews: \(view)") // helpful for sorting out which view is which
        if view.frame.origin.x > 700 { // find _my_ button
            view.layer.cornerRadius = 5
            view.layer.borderColor = UIColor.red.cgColor
            view.layer.borderWidth = 2
        }
        for v in view.subviews { recurseViews(view: v) }
    }
}
