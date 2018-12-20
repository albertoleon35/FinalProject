//
//  CollectionViewCell.swift
//  finalProject
//
//  Created by Alberto Leon on 12/17/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var killDeathRatiolLabel: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var damagePerGameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with player: PlatformUserDTO) {
        
        guard let player1 = player.callOfDuty else {
            self.playerNameLabel.text = player.gamerTag
            return;
        }
        
        self.killDeathRatiolLabel.text = getPlayerStatsValueByKey(key: "KDRatio", player: player1)
        self.damagePerGameLabel.text =  getPlayerStatsValueByKey(key: "DamagePerGame", player: player1)
        self.deathsLabel.text = getPlayerStatsValueByKey(key: "Deaths", player: player1)
        self.killsLabel.text = getPlayerStatsValueByKey(key: "Kills", player: player1)
        self.rankLabel.text = getPlayerStatsValueByKey(key: "RankXP", player: player1)
        self.playerNameLabel.text = player.callOfDuty?.data?.metadata?.platformUserHandle

           
    }
    
    fileprivate func getPlayerStatsValueByKey(key: String, player: CallOfDuty) -> String? {
        
        guard let stats = player.data?.stats else {
            return ""
        }
        
        for stat in stats {
            guard let categoryKey = stat.metadata?.key else {
                continue
            }
            
            if( categoryKey ==  key ) {
                return stat.displayValue
            }
        }
        
        return ""
    }
}
