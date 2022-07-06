//
//  SearchViewController.swift
//  M-Commerce Shop
//
//  Created by Kyrillos Kamal on 03.07.22.
//

import UIKit

class SearchViewController: UIViewController {

 
    let data = ["adidas-classic-backpack", "timberland-mens", "vans-era", "dr-martens", "flex-fit-mini-ottoman-black"]
    var filteredData: [String]?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notFoundImage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredData = data
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        notFoundImage.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        if  self.filteredData?.isEmpty ?? true{
            notFoundImage.isHidden = false
            tableView.isHidden = true

        }else {

            notFoundImage.isHidden = true
            tableView.isHidden = false
            self.tableView.reloadData()
        }
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

extension SearchViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredData?[indexPath.row]
        
        return cell
    }
    
    
}

extension SearchViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText.isEmpty{
            filteredData = data
            tableView.isHidden = false
            notFoundImage.isHidden = true
        }else{
            
            for word in data {
                
                if word.uppercased().contains(searchText.uppercased())
                {
                    filteredData?.append(word)
                    notFoundImage.isHidden = true
                    tableView.isHidden = false
                }

            }
            if filteredData?.count == 0 {
                    notFoundImage.isHidden = false
                    tableView.isHidden = true
                
            }
        }
        self.tableView.reloadData()
    }
}

