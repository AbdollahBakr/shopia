//
//  OrdersVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 07/07/2022.
//

import UIKit

class OrdersVC: UITableViewController {
    
    var viewModelInstance   : OrdersViewModel?
    var customerOrdersArray = [OrdersLineItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "OrdersCell", bundle: nil), forCellReuseIdentifier: "OrdersCell")
        //listOrders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listOrders()
    }
    
    func listOrders(){
        Helper.hudProgress()
        viewModelInstance = OrdersViewModel()
        self.viewModelInstance?.listOrders(variant_id: UserDefaults.value(forKey: "userId") as! String)
        viewModelInstance?.bindOrdersToHomeView = { [weak self] in
            DispatchQueue.main.async {
                Helper.dismissHud()
                self?.customerOrdersArray = self?.viewModelInstance?.ordersArray ?? []
                self?.tableView.reloadData()
            }
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerOrdersArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersCell", for: indexPath) as? OrdersCell else {
            return UITableViewCell()
        }
        cell.prderPriceLabel.text = self.customerOrdersArray[indexPath.row].price
       // cell.configureCell(order: self.customerOrdersArray[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
