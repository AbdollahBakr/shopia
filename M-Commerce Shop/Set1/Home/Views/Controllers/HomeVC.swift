//
//  HomeVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 26/06/2022.
//

import UIKit


class HomeVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    /* Variables
       Has instance from ViewModel to Load (logic/Func) from it */
    var viewModelInstance : HomeViewModel?
    // Instance For Implementing Composotional Layout Logic
    var compostionalLayoutInstance = ComposotionalLayout()
    let menuButton        = UIButton()
    var brandsArray       = [SmartCollections]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        searchBar.delegate = self
        DismissSearchBar()
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureNavBar()
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listBrands()
    }
    
    fileprivate func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        // CollectionView Cells
        collectionView.register(UINib(nibName: "BrandsCell", bundle: nil), forCellWithReuseIdentifier: "BrandsCell")
        
        // CollectionView Header
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil),forSupplementaryViewOfKind: "header",withReuseIdentifier:"HeaderView")
        
        //compostionalLayoutInstance = ComposotionalLayout()
        
        collectionView.collectionViewLayout = compostionalLayoutInstance.createcompositionalLayout()
    }
    
    
    
    // MARK: - <configureNavBar>
    fileprivate func configureNavBar() {
       
        searchBar.delegate = self
        
        navigationController?.navigationBar.sizeToFit()
        
        self.navigationItem.rightBarButtonItem = nil
        
        // Left Button
        menuButton.setImage(UIImage (named: "menu"), for: .normal)
        menuButton.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        menuButton.backgroundColor = UIColor(named: "GreyColor")
        menuButton.layer.cornerRadius = menuButton.frame.width / 2
        menuButton.layer.shadowOpacity = 0.3
        menuButton.layer.shadowOffset = CGSize.zero
        menuButton.layer.shadowRadius = 2
        let barButtonItem = UIBarButtonItem(customView: menuButton)
        
        self.navigationItem.leftBarButtonItems = [barButtonItem]
        
        // Right Buttons
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage (named: "Cart"), for: .normal)
        button2.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        button2.layer.cornerRadius = button2.frame.width / 2
        button2.backgroundColor = UIColor(named: "GreyColor")
        button2.layer.shadowOpacity = 0.3
        button2.layer.shadowOffset = CGSize.zero
        button2.layer.shadowRadius = 2
        let barButtonItem2 = UIBarButtonItem(customView: button2)
        
        
        
        let button3 = UIButton(type: .custom)
        button3.setImage(UIImage (named: "Heart"), for: .normal)
        button3.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        button3.layer.cornerRadius = button3.frame.width / 2
        button3.backgroundColor = UIColor(named: "GreyColor")
        button3.layer.shadowOpacity = 0.3
        button3.layer.shadowOffset = CGSize.zero
        button3.layer.shadowRadius = 2
        //button.addTarget(target, action: nil, for: .touchUpInside)

        
        let barButtonItem3 = UIBarButtonItem(customView: button3)
        
        self.navigationItem.rightBarButtonItems = [barButtonItem2,barButtonItem3]
        
        
    }
    
    func DismissSearchBar() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    func listBrands() {

        viewModelInstance = HomeViewModel()
        self.viewModelInstance?.listBrands()
        viewModelInstance?.bindBrandsToHomeView = { [weak self] in
            DispatchQueue.main.async {
                Helper.dismissAnimation()
                self?.brandsArray = self?.viewModelInstance?.brandsArray ?? []
                //self?.filteredSportsArr = (self?.sportsArray)!
                self?.collectionView.reloadData()
            }
        }
        
    }
    
    @objc func singleTap(sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
    }
    
    
}
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        
        case 0:
            return brandsArray.count

            
//        case 1:
//            return leageDetailsData?.count ?? 1
//
//        case 2:
//            return leagueTeams?.count      ?? 1
            
        default:
            print("Error")
            return 0
        }

        
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        
        case 0:
            guard let firstView = self.collectionView.dequeueReusableSupplementaryView(ofKind: compostionalLayoutInstance.sectionHeaderElementKind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
                return UICollectionReusableView()
            }
            
            firstView.headerLabel.text =  "Choose Brand"
            return firstView

            

        

//        case 1:
//            guard let secondView = self.collectionView.dequeueReusableSupplementaryView(ofKind: Constants.sectionHeaderElementKind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
//                return UICollectionReusableView()
//            }
//
//            secondView.headerLabel.text =  "Latest Results"
//            secondView.headerLabel.textAlignment = .left
//            return secondView

//
   
//        case 2:
//
//            guard let thirdView = self.collectionView.dequeueReusableSupplementaryView(ofKind: Constants.sectionHeaderElementKind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
//                return UICollectionReusableView()
//            }
//
//            thirdView.headerLabel.text =  "Teams"
//            thirdView.headerLabel.textAlignment = .left
//            return thirdView

            

            
        default:
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       

        
        switch indexPath.section {
        
        case 0:

           
            guard let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsCell", for: indexPath) as? BrandsCell else {
                return UICollectionViewCell()
            }

            firstCell.configureCell(brands: self.brandsArray[indexPath.row])
            return firstCell
            

//        case 1:
//
//            guard let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacingTeamsCell", for: indexPath) as? FacingTeamsCell else {
//                return UICollectionViewCell()
//            }
//
//            secondCell.configureCell(teamData: self.leageDetailsData?[indexPath.row])
//            return secondCell
//
//        case 2:
//
//            guard let thirdCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as? TeamsCell else {
//                return UICollectionViewCell()
//            }
//
//            thirdCell.configureCell(leagueDetails: leagueTeams?[indexPath.row])
//            return thirdCell
            
        default:
            
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
//        case 2:

//            let storyboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
//            guard let vc         = storyboard.instantiateViewController(withIdentifier:"TeamDetailsVC") as? TeamDetailsVC else {return}
//
//            vc.name  = self.leagueTeams?[indexPath.row].strTeam
//            vc.image = self.leagueTeams?[indexPath.row].strTeamBadge
//
//            vc.modalPresentationStyle = .fullScreen
//
//            self.present(vc, animated: true)

//        let storyboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
//        guard let vc         = storyboard.instantiateViewController(withIdentifier:"TeamDetailsVC") as? TeamDetailsVC else {return}
//
//        vc.name  = self.leagueTeams?[indexPath.row].strTeam
//        vc.image = self.leagueTeams?[indexPath.row].strTeamBadge
//
//        vc.modalPresentationStyle = .fullScreen
//
//        self.present(vc, animated: true)

        default:
            print("error")
        }
    }
}

