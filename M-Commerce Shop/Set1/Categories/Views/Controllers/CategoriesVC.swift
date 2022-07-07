//
//  MainProductsVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 06/07/2022.
//

import UIKit
import Kingfisher

class CategoriesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayCategories   = [Custom_collections]()
    var viewModelInstance : CategoryViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellReuseIdentifier: "CategoriesCell")
        tableView.delegate  = self
        tableView.dataSource = self

        listCategories()
    }
    
    func listCategories() {
        viewModelInstance = CategoryViewModel()
        viewModelInstance?.listCategories()
        viewModelInstance?.bindCategoriesToProductsView = { [weak self] in
            DispatchQueue.main.async {
                self?.arrayCategories = self?.viewModelInstance?.categoriesArray ?? []
                self?.tableView.reloadData()
            }
        }
    }
    

}

extension CategoriesVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as? CategoriesCell else {
            return UITableViewCell()
        }
        
        if let url = URL(string: arrayCategories[indexPath.row].image?.src ?? "") {
            let placeholder = UIImage(named: "placeholder")
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
            cell.categoryImage.kf.indicatorType = .activity
            cell.categoryImage.kf.setImage(with: url,placeholder: placeholder,options: options)
            cell.categoryName.text = "  \(arrayCategories[indexPath.row].title ?? "")"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Categories", bundle: nil)

        guard let shoeVC   = storyboard.instantiateViewController(withIdentifier:"ShoesVC") as? SubCategoriesVC else {return}

        shoeVC.collection_id        = arrayCategories[indexPath.row].id
        
        shoeVC.modalPresentationStyle = .fullScreen
        present(shoeVC, animated: true)
    }
}
