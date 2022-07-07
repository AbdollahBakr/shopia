//
//  HomeVC.swift
//  M-Commerce Shop
//
//  Created by Abdallah Eslah Mac on 26/06/2022.
//

import UIKit
import Speech


class HomeVC: UIViewController {
    
    @IBOutlet weak var btn_start: RoundedButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    /* Variables
       Has instance from ViewModel to Load (logic/Func) from it */
    var viewModelInstance : HomeViewModel?
    // Instance For Implementing Composotional Layout Logic
    var compostionalLayoutInstance = ComposotionalLayout()
    let menuButton        = UIButton()
    var brandsArray       = [SmartCollections]()
    var filteredData      : [SmartCollections]?

    //MARK: - Local Properties
    var audioEngine                           = AVAudioEngine()
    let speechReconizer : SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task : SFSpeechRecognitionTask!
    var isStart : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listBrands()
        setupCollectionView()
        searchBar.delegate = self
        DismissSearchBar()
        filteredData = brandsArray
        configureMenu()
        requestPermission()
    }
   

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureNavBar()
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Helper.showAnimation()
        listBrands()
    }
    
    func configureMenu() {
           
           if self.revealViewController() != nil {
               menuButton.addTarget(self.revealViewController(),
                                    action: #selector(revealViewController().revealToggle(_:)),
                                    for: .touchUpInside)
               self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
           }
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
        
        navigationController?.navigationBar.sizeToFit()
        
        self.navigationItem.rightBarButtonItem = nil
        
        // Left Button
        menuButton.setImage(UIImage (named: "menu"), for: .normal)
        menuButton.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        menuButton.backgroundColor = UIColor(named: "GreyColor")
        menuButton.layer.cornerRadius = menuButton.frame.width / 2
        menuButton.tintColor = .black
        menuButton.layer.shadowOpacity = 0.3
        menuButton.layer.shadowOffset = CGSize.zero
        menuButton.layer.shadowRadius = 2
        let barButtonItem = UIBarButtonItem(customView: menuButton)
        
        self.navigationItem.leftBarButtonItems = [barButtonItem]
        
        // Right Buttons
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(systemName: "cart"), for: .normal)
        button2.tintColor = .black
        button2.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        button2.layer.cornerRadius = button2.frame.width / 2
        button2.backgroundColor = UIColor(named: "GreyColor")
        button2.layer.shadowOpacity = 0.3
        button2.layer.shadowOffset = CGSize.zero
        button2.layer.shadowRadius = 2
        button2.addTarget(self, action: #selector(goToCart), for: .touchUpInside)
        let barButtonItem2 = UIBarButtonItem(customView: button2)
        
        
        let button3 = UIButton(type: .custom)
        button3.setImage(UIImage (named: "Heart"), for: .normal)
        button3.tintColor = .black
        button3.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        button3.layer.cornerRadius = button3.frame.width / 2
        button3.backgroundColor = UIColor(named: "GreyColor")
        button3.layer.shadowOpacity = 0.3
        button3.layer.shadowOffset = CGSize.zero
        button3.layer.shadowRadius = 2
        button3.addTarget(self, action: #selector(goToWishlist), for: .touchUpInside)

        
        
        let barButtonItem3 = UIBarButtonItem(customView: button3)
        
        self.navigationItem.rightBarButtonItems = [barButtonItem2,barButtonItem3]
    
    }
    
    @objc func goToCart(){
        guard let cartVC = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(identifier: "CartViewController") as? CartViewController else {return}
        present(cartVC, animated: true)
    }
    
    @objc func goToWishlist(){
        guard let wishlistVC = UIStoryboard(name: "Wishlist", bundle: nil).instantiateViewController(identifier: "WishlistViewController") as? WishlistViewController else {return}
        present(wishlistVC, animated: true)
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
                self?.filteredData  = self?.brandsArray
                self?.collectionView.reloadData()
            }
        }
        
    }
    
    @objc func singleTap(sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
    }
    
    /**** Audio Recognition***/
        func startSpeechRecognization(){
            
            let node = audioEngine.inputNode
            let recordingFormat = node.outputFormat(forBus: 0)
            
            node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
                self.request.append(buffer)
            }
            
            audioEngine.prepare()
            do {
                try audioEngine.start()
            } catch let error {
                alertView(message: "Error comes here for starting the audio listner =\(error.localizedDescription)")
            }
            
            guard let myRecognization = SFSpeechRecognizer() else {
                self.alertView(message: "Recognization is not allow on your local")
                return
            }
            
            print(myRecognization.isAvailable)
            if !myRecognization.isAvailable {
                self.alertView(message: "Recognization is not free right now, Please try again after some time.")
            }
            
            task = speechReconizer?.recognitionTask(with: request, resultHandler: { (response, error) in
                guard let response = response else {
                    if error != nil {
                        self.alertView(message: error.debugDescription)
                    }else {
                        self.alertView(message: "Problem in giving the response")
                    }
                    return
                }
                
                let message = response.bestTranscription.formattedString
                print("Message : \(message)")
                self.searchBar.text = message
                
                var lastString: String = ""
                for segment in response.bestTranscription.segments {
                    let indexTo = message.index(message.startIndex, offsetBy: segment.substringRange.location)
                    lastString = String(message[indexTo...])
                }
                
                if lastString == "red" {
                    self.searchBar.backgroundColor = .systemRed
                } else if lastString.elementsEqual("green") {
                    self.searchBar.backgroundColor = .systemGreen
                } else if lastString.elementsEqual("pink") {
                    self.searchBar.backgroundColor = .systemPink
                } else if lastString.elementsEqual("blue") {
                    self.searchBar.backgroundColor = .systemBlue
                } else if lastString.elementsEqual("black") {
                    self.searchBar.backgroundColor = .black
                }
            })
        }
        
        func requestPermission()  {
               self.btn_start.isEnabled = false
               SFSpeechRecognizer.requestAuthorization { (authState) in
                   OperationQueue.main.addOperation {
                       if authState == .authorized {
                           print("ACCEPTED")
                           self.btn_start.isEnabled = true
                       } else if authState == .denied {
                           self.alertView(message: "User denied the permission")
                       } else if authState == .notDetermined {
                           self.alertView(message: "In User phone there is no speech recognization")
                       } else if authState == .restricted {
                           self.alertView(message: "User has been restricted for using the speech recognization")
                       }
                   }
               }
           }
           
           
           
           func cancelSpeechRecognization() {
               task.finish()
               task.cancel()
               task = nil
               
               request.endAudio()
               audioEngine.stop()
               //audioEngine.inputNode.removeTap(onBus: 0)
               
               //MARK: UPDATED
               if audioEngine.inputNode.numberOfInputs > 0 {
                   audioEngine.inputNode.removeTap(onBus: 0)
               }
           }
           
           
           func alertView(message : String) {
               let controller = UIAlertController.init(title: "Error ocured...!", message: message, preferredStyle: .alert)
               controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                   controller.dismiss(animated: true, completion: nil)
               }))
               self.present(controller, animated: true, completion: nil)
           }
    
    @IBAction func goToAds(_ sender: Any) {
        guard let adsVC = UIStoryboard(name: "Ads", bundle: nil).instantiateViewController(identifier: "AdsViewController") as? AdsViewController else {return}
        present(adsVC, animated: true)
    }
    
}
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource {

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        
        case 0:
            return filteredData?.count ?? 0

            
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

            firstCell.configureCell(brands: self.filteredData?[indexPath.row])
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
        
        case 0:
            
            let storyboard = UIStoryboard(name: "BrandProducts", bundle: nil)
            guard let vc   = storyboard.instantiateViewController(withIdentifier:"BrandProductsVC") as? BrandProductsVC else {return}
            
            vc.brandId   = self.filteredData?[indexPath.row].id
            vc.brandName = self.filteredData?[indexPath.row].title
            navigationController?.show(vc, sender: self)
            
//        case 1:
            
            
            
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
    
    @IBAction func startAndFinishRecording(_ sender: Any) {
            isStart = !isStart
            if isStart {
                startSpeechRecognization()
                //btn_start.setTitle("STOP", for: .normal)
                btn_start.backgroundColor = .systemGreen
            }else {
                cancelSpeechRecognization()
                //btn_start.setTitle("START", for: .normal)
                btn_start.backgroundColor = UIColor(named: "BlueColor")
            }
        }
}

extension HomeVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText == ""{
            filteredData = brandsArray
        }else{
            for product in brandsArray{
                guard let title = product.title else{return}
                
                if title.uppercased().contains(searchText.uppercased()) {
                    filteredData?.append(product)
                    self.collectionView.reloadData()
                }
            }
        }
        self.collectionView.reloadData()
    }
}

