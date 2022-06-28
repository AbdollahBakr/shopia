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
        print(SettingsViewModel.settingsCells[indexPath.row].settingOption)
        
        switch SettingsViewModel.settingsCells[indexPath.row].settingOption {
        case "Address":
            guard let addressesVC = storyboard?.instantiateViewController(withIdentifier: "AddressesViewController") else { return }
            presentVC(vc: addressesVC, animated: true)
        default:
            print("No View controllers to present")
        }
    }
    
}
