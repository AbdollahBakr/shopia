//
//  WomenVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 04/07/2022.
//

import UIKit
import Kingfisher

class WomenVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrayCategories = [Custom_collections]()
    var viewModelInstance : CategoryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellReuseIdentifier: "CategoriesCell")
        tableView.delegate  = self
        tableView.dataSource = self
//        let data1 = CategoriesModel(name: "Clothes", image: "Clothes")
      //        arrayCategories.append(data1)
      //        let data2 = CategoriesModel(name: "Shoes", image: "Shoes")
      //        arrayCategories.append(data2)
      //        let data3 = CategoriesModel(name: "Accessories", image: "Accessories")
      //        arrayCategories.append(data3)
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

      extension WomenVC: UITableViewDelegate,UITableViewDataSource {
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
      }
