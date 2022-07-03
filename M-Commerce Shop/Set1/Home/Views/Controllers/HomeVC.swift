//
//  HomeVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 26/06/2022.
//

import UIKit

class HomeVC: UIViewController, UISearchBarDelegate {
    
    let searchBar  = UISearchBar()
    let menuButton = UIButton()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureSearchBar()
    }
    
    
    // MARK: - <SearchBar>
    fileprivate func configureSearchBar() {
        let searchText = "Restaurants Search..."
        searchBar.placeholder = searchText
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .white
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.titleView = searchBar
        
        // accessing childView - textField inside of the searchBar
        let searchBar_textField = searchBar.value(forKey: "searchField") as? UITextField
        searchBar_textField?.textColor = .white
        searchBar_textField?.tintColor = .white
        searchBar.delegate = self
        
        // insert searchBar into navigationBar
        self.navigationItem.titleView = searchBar
        
        navigationController?.navigationBar.sizeToFit()
        
        self.navigationItem.rightBarButtonItem = nil
        
        // Left Button
        menuButton.setImage(UIImage (named: "menu"), for: .normal)
        menuButton.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        let barButtonItem = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItems = [barButtonItem]
        
        // Right Buttons
        let button2 = UIButton(type: .custom)
//        button2.isUserInteractionEnabled = false
        button2.setImage(UIImage (named: "Cart"), for: .normal)
        button2.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        let barButtonItem2 = UIBarButtonItem(customView: button2)
        
        
        let button3 = UIButton(type: .custom)
//        button3.isUserInteractionEnabled = false
        button3.setImage(UIImage (named: "Heart"), for: .normal)
        button3.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        //button.addTarget(target, action: nil, for: .touchUpInside)

        
        let barButtonItem3 = UIBarButtonItem(customView: button3)
        
        self.navigationItem.rightBarButtonItem = barButtonItem2
        self.navigationItem.rightBarButtonItem = barButtonItem3
        
    }
    
    func DismissSearchBar() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func singleTap(sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
    }
}
