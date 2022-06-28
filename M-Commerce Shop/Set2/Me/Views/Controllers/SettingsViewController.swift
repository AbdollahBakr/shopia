//
//  SettingsViewController.swift
//  M-Commerce Shop
//
//  Created by Abdollah Bakr on 28/06/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var backButton: CircleButtonShadowView!
    
    var settingsRows = [String:String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
//        settingsTableView.cornerRadius = 10
        backButton.setTitle("", for: .normal)
        
        settingsRows = ["Address":"Cairo", "Currency": "EGP", "Contact us": "", "About us": ""]
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

// TableView Delegate & DataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "SettingsTableViewCell")
 
        // Configure settings cells
        cell.textLabel?.text = SettingsViewModel.settingsCells[indexPath.row].settingOption
        cell.detailTextLabel?.text = SettingsViewModel.settingsCells[indexPath.row].settingValue
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        switch SettingsViewModel.settingsCells[indexPath.row].settingOption {
        case "Address":
            guard let addressesVC = storyboard?.instantiateViewController(withIdentifier: "AddressesViewController") else { return }
            presentVC(vc: addressesVC, animated: true)
            
        case "Currency":
            // Change currency
            changeCurrency(settingsCellLocation: indexPath.row)
        default:
            print("No View controllers to present")
        }
    }
    
    
    // ActionSheet for changing currency
    func changeCurrency(settingsCellLocation: Int) {
        let alert: UIAlertController = UIAlertController(title: "Currency",
                                                         message: "Please select a currency",
                                                         preferredStyle: .actionSheet)
        // Set currency to EGP
        alert.addAction(UIAlertAction(title: "EGP", style: .default,
                                      handler: { action in
            Helper.hudProgress()
            SettingsViewModel.settingsCells[settingsCellLocation].settingValue = "EGP"
            self.settingsTableView.reloadData()
            Helper.dismissHud()
        }))
        
        // Set currency to USD
        alert.addAction(UIAlertAction(title: "USD", style: .default,
                                      handler: { action in
            Helper.hudProgress()
            SettingsViewModel.settingsCells[settingsCellLocation].settingValue = "USD"
            self.settingsTableView.reloadData()
            Helper.dismissHud()
        }))
        
        // Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,
                                      handler: { action in
            // No need. Added, for now, to deselect the currency cell
            self.settingsTableView.reloadData()
        }))
        
        self.present(alert, animated: true)
    }
    
}



    


