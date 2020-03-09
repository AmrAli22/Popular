//
//  CelebrityTableViewCell.swift
//  Popular
//
//  Created by Sherif Darwish on 3/7/20.
//  Copyright © 2020 TheAmrAli. All rights reserved.
//

import UIKit

class CelebrityTableViewCellViewModel: UITableViewCell {


    @IBOutlet weak var nameLabel: UILabel!
     @IBOutlet weak var KnownAs: UILabel!
    
    var celebrityViewModel : CelebrityCellViewModel? {
        didSet {
            nameLabel.text = celebrityViewModel?.Name
            KnownAs.text = celebrityViewModel?.KnownFor

        }
    }
    
}
