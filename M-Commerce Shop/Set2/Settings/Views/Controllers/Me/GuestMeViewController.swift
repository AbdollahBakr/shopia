//
//  GuestMeViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 28/06/2022.
//

import UIKit

class GuestMeViewController: UIViewController {
    
    @IBOutlet weak var settingsButton: CircleButtonShadowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingsButton.setTitle("", for: .normal)
    }
    
}
