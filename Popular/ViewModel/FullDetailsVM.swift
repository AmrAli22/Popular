//
//  FullDetailsVM.swift
//  Popular
//
//  Created by Sherif Darwish on 3/9/20.
//  Copyright © 2020 TheAmrAli. All rights reserved.
//


import Foundation
import UIKit

class FullDetailsVM {
    
    let apiService: APIServiceFullDetailsProtocol?
    
    //var CelebrityImages =  [UIImage]()
    
    var CelebrityImages = [UIImage]()
    
     var FullDetailedCelebrity : FullCelebrity?  {
        didSet {
            self.populted?()
        }
    }
    
    // callback for interfaces
    var state: State = .initalize {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var CelebrityID = 0

    
    var initilize: (()->())?
    var populted: (()->())?
    var ReloadCollectionView: (()->())?
    var updateLoadingStatus: (()->())?
    
    init( apiService: APIServiceFullDetailsProtocol = ApiFullDetails() , celebrityId : Int ) {
        
        self.apiService = apiService
        self.CelebrityID = celebrityId
    }
    
    func GetCelebrityImages(Id:Int)  {
        apiService?.fetchCelebritryImagesUrls(Id: CelebrityID,  complete: { [weak self]  (Sucsess, urls, error) in
            guard let self = self else {
                return
            }
            if Sucsess {
                for imageUrl in urls! {
                self.apiService?.fetchCelebritryImages(Url: imageUrl, complete: {  [weak self] (Sucess, Image, error) in
                    guard let self = self else {
                        return
                    }
                    if Sucess{
                        print("succes in get CelebityImages with image = \(Image)")
                        self.CelebrityImages.append(Image!)
                        self.state = .ReadyForImages
                        self.ReloadCollectionView?()
                        print("CelebrityImagesCount = \(self.CelebrityImages.count)")
                    }
                })
            }
            }
        })
    }
    
    
    
    func ForwaredImages(index : IndexPath) -> UIImage {
        return (CelebrityImages[index.row])
    }
    
    func initFillDetailsRequest() {
        print("Called initFillDetailsReauest")
        state = .initalize
        apiService!.fetchFullDetailsCelebritry(Id: CelebrityID ) { [weak self] (success, celebrity, error) in
            guard let self = self else {
                return
            }
            
            guard error == nil else {
                self.state = .error
                return
            }
            self.FullDetailedCelebrity = celebrity
            self.state = .populated            
        }
    }
    
}

