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
    
    var viewModel: SettingsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
//        settingsTableView.cornerRadius = 10
        backButton.setTitle("", for: .normal)
        
        viewModel = SettingsViewModel()
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
        return SettingsViewModel.settingsCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "SettingsTableViewCell")
 
        // Configure settings cells
        cell.textLabel?.text = SettingsViewModel.settingsCells[indexPath.row].settingOption.rawValue
        cell.detailTextLabel?.text = SettingsViewModel.settingsCells[indexPath.row].settingValue
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        switch SettingsViewModel.settingsCells[indexPath.row].settingOption {
        case .address:
            guard let addressesVC = storyboard?.instantiateViewController(withIdentifier: "AddressesViewController") else { return }
            presentVC(vc: addressesVC, animated: true)
            
        case .currency:
            // Change currency
            changeCurrency(settingsCellLocation: indexPath.row)
        
        case .contactUs:
            guard let contactUsVC = storyboard?.instantiateViewController(withIdentifier: "ContactUs") else { return }
            present(contactUsVC, animated: true)
        
        case .aboutUs:
            guard let aboutUsVC = storyboard?.instantiateViewController(withIdentifier: "AboutUs") else { return }
            present(aboutUsVC, animated: true)

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



    


