//
//  CategoriesVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 04/07/2022.
//

import UIKit

class CategoriesVC: UIViewController {
    
    @IBOutlet weak var menContainer: UIView!
    @IBOutlet weak var womenContainer: UIView!
    @IBOutlet weak var kidsContainer: UIView!
    @IBOutlet weak var saleContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func segmentControlTapped(_ sender: AnyObject) {
        
        if (sender.selectedSegmentIndex == 0 ) {
            UIView.animate(withDuration: 0.5) {
                self.menContainer.alpha = 1
                self.womenContainer.alpha = 0
                self.kidsContainer.alpha = 0
                self.saleContainer.alpha = 0
                
            }
        }else if (sender.selectedSegmentIndex == 1) {
            UIView.animate(withDuration: 0.5) {
                self.menContainer.alpha = 0
                self.womenContainer.alpha = 1
                self.kidsContainer.alpha = 0
                self.saleContainer.alpha = 0
                
            }
        } else if (sender.selectedSegmentIndex == 2){
            UIView.animate(withDuration: 0.5) {
                self.menContainer.alpha = 0
                self.womenContainer.alpha = 0
                self.kidsContainer.alpha = 1
                self.saleContainer.alpha = 0
                
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.menContainer.alpha = 0
                self.womenContainer.alpha = 0
                self.kidsContainer.alpha = 0
                self.saleContainer.alpha = 1
            }
        }
    }
}
