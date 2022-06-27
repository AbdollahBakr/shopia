//
//  MeViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 27/06/2022.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var settingsButton: CircleButtonShadowView!
    
    @IBOutlet weak var cartButton: CircleButtonShadowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        settingsButton.setTitle("", for: .normal)
        cartButton.setTitle("", for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
