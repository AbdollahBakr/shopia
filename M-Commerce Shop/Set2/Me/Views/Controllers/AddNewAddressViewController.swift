//
//  AddNewAddressViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 28/06/2022.
//

import UIKit

class AddNewAddressViewController: UIViewController {
    
    @IBOutlet weak var backButton: CircleButtonShadowView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backButton.setTitle("", for: .normal)
    }
    

    @IBAction func backToAddresses(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func saveNewAddress(_ sender: UIButton) {
        Helper.displayMessage(message: "Can't Save the New Address", messageError: true)
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
