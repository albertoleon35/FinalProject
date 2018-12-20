//
//  DetailedPlayerStatisticsCollectionViewController.swift
//  finalProject
//
//  Created by Alberto Leon on 12/17/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import UIKit

class DetailedPlayerStatisticsCollectionViewController: UICollectionViewController {

    private let detailedStatisticsHeader = "detailedStatisticsHeader"
    private let detailedStatistics = "detailedStatistics"
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var followedUsers = [PlatformUserDTO]()
    var currentUser: UserDTO?
    var detailedData = [ExternalModelWrapper]()
    var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: self.detailedStatistics)
        
        getPlayerDetails()
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.detailedStatisticsHeader, for: indexPath)
        
        //        header.backgroundColor = .green
        header.layer.shadowColor = UIColor.black.cgColor
        header.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        header.layer.shadowRadius = 2.0
        header.layer.shadowOpacity = 0.5
        header.layer.masksToBounds = false
        
        return header
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.detailedData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.detailedStatistics, for: indexPath) as! CollectionViewCell
        
        let player = followedUsers[indexPath.row]
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        
        
        cell.configure(with: player)
        return cell
    }
    
    fileprivate func getPlayerDetails() {
        let gateway = Gateway()
        
        followedUsers.forEach { $0
            //public API has a limitation of calling it once every two seconds
            gateway.getPlayerStats(player: $0) { response in
                
                guard let value = response else {
                    return
                }
                
                self.followedUsers.forEach{
                    if ($0.gamerTag  == value.callOfDuty?.data?.metadata?.platformUserHandle) {
                        $0.callOfDuty = value.callOfDuty
                        $0.errorMessage = value.errorMessage
                    }
                }
                
                self.detailedData.append(value)
                if(self.detailedData.count == self.followedUsers.count) {
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                }
            }
        }
        
        
    }
}
