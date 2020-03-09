//
//  ImageCollectionViewCell.swift
//  Popular
//
//  Created by Sherif Darwish on 3/9/20.
//  Copyright © 2020 TheAmrAli. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var Image: UIImageView!
    
    func SetImage(image : UIImage) {
        self.Image.image = image
    }
    
}
