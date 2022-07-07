//
//  MenVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 04/07/2022.
//

import UIKit
import Kingfisher

class SubCategoriesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    // Variables
    var collection_id      : Int?
    var product_type       : String?
    var viewModelInstance  : CategoryViewModel?
    var arraySubCategory   = [ProductsResult]()
    var filteredData      : [ProductsResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenu()
        tableView.register(UINib(nibName: "CategoryProductsCell", bundle: nil), forCellReuseIdentifier: "CategoryProductsCell")
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        filteredData = arraySubCategory
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        listShoes(product_type: "SHOES")
    }
    
    func configureMenu() {
        
        let shoes = UIAction(title: "Shoes", image: UIImage(named: "Shoes")) { (action) in
         
         self.listShoes(product_type: "SHOES")
            
        }

        let t_shirts = UIAction(title: "T-Shirts", image: UIImage(named: "T-shirts")) { (action) in
            
            self.listShoes(product_type: "T-SHIRTS")
            
        }
        
        let accessoriesVC = UIAction(title: "Accessories", image: UIImage(named: "Accessories")) { (action) in
            
                
            self.listShoes(product_type: "ACCESSORIES")
            
        }

           let menu = UIMenu(title: "Filter Products", options: .displayInline, children: [ shoes, t_shirts , accessoriesVC])
        filterButton.menu = menu
        filterButton.showsMenuAsPrimaryAction = true
    }
    
    func listShoes(product_type:String) {
        Helper.hudProgress()
        viewModelInstance = CategoryViewModel()
        viewModelInstance?.listProductsOfSubCategories(collection_id: collection_id ?? 0 , product_type: product_type)
        viewModelInstance?.bindCategories3ToProductsView = { [weak self] in
            DispatchQueue.main.async {
                Helper.dismissHud()
                self?.arraySubCategory = self?.viewModelInstance?.categoriesArray3 ?? []
                self?.filteredData  = self?.arraySubCategory
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension SubCategoriesVC:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryProductsCell", for: indexPath) as? CategoryProductsCell else {return UITableViewCell()}
        cell.configureCell(product:(self.filteredData?[indexPath.row])!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = arraySubCategory[indexPath.item]
                
        guard let productDetailsVC = UIStoryboard(name: "ProductDetails", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController else {return}
        
        productDetailsVC.productID = product.id
        
        presentVC(vc: productDetailsVC, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    
}

extension SubCategoriesVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText == ""{
            filteredData = arraySubCategory
        }else{
            for product in arraySubCategory{
                guard let title = product.title else{return}
                
                if title.uppercased().contains(searchText.uppercased()) {
                    filteredData?.append(product)
                    self.tableView.reloadData()
                }
            }
        }
        self.tableView.reloadData()
    }
}
