//
//  CollectionViewExtensions.swift
//  Popular
//
//  Created by Sherif Darwish on 3/10/20.
//  Copyright © 2020 TheAmrAli. All rights reserved.
//

import UIKit

extension FullDetailsViewController:UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.CelebrityImages.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "CelebrityImage", for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        if (viewModel.updateLoadingStatus != nil){
            if viewModel.state == .ReadyForImages{
                let cellVMImage = viewModel.ForwaredImages(index: indexPath)
                cell.SetImage(image: cellVMImage)
                return cell
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
