//
//  FullImageViewController.swift
//  Popular
//
//  Created by Sherif Darwish on 3/10/20.
//  Copyright © 2020 TheAmrAli. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController {

    @IBOutlet weak var FullImage: UIImageView!
    var image = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.FullImage.image =  self.image 
    }
    
    @IBAction func DawnloadImage(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(self.FullImage.image!, nil, nil, nil)
        
    }
    
    @IBAction func BackBtnPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
}
