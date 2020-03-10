//
//  FullDetailsViewController.swift
//  Popular
//
//  Created by Sherif Darwish on 3/9/20.
//  Copyright © 2020 TheAmrAli. All rights reserved.
//

import UIKit

class FullDetailsViewController: UIViewController {
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var LblName: UILabel!
    @IBOutlet weak var LblDob: UILabel!
    @IBOutlet weak var LblPod: UILabel!
    @IBOutlet weak var TxtFieldBio: UITextView!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var PassedCelebrityId = Int()
    var SelectedImageIndex = IndexPath()

    
    var celebrityDetails : FullCelebrity? {
        didSet {
            self.LblName.text = celebrityDetails?.name
            self.LblPod.text = celebrityDetails?.placeOfBirth
            self.LblDob.text = celebrityDetails?.birthday
            self.TxtFieldBio.text = celebrityDetails?.biography
        }
    }
    
    lazy var viewModel: FullDetailsVM = {
        return FullDetailsVM(celebrityId: PassedCelebrityId )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        CollectionView.isPagingEnabled = true
        CollectionView.showsHorizontalScrollIndicator = false
        
        self.HideViews()
        
        initFetchDetails()
        
    
    }
    
    @objc func receivingId(sender: NSNotification){
        self.PassedCelebrityId = sender.userInfo!["ID"] as! Int
    }
    
    @IBAction func Back(_ sender: Any) {
        let Home = UIStoryboard(name: "Main", bundle: nil)
        let HomeVC = Home.instantiateViewController(withIdentifier: "Home") as! Home
        present(HomeVC, animated: true , completion: nil)
    }
    
    
    func HideViews() {
        self.LblDob.isHidden = true
        self.LblPod.isHidden = true
        self.LblName.isHidden = true
        self.TxtFieldBio.isHidden = true
        self.CollectionView.isHidden = true
    }
    
    func ShowViews() {
        self.LblDob.isHidden = false
        self.LblPod.isHidden = false
        self.LblName.isHidden = false
        self.TxtFieldBio.isHidden = false
        self.TxtFieldBio.setContentOffset(.zero, animated: false)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        if (segue.identifier == "ToFullImage") {
        if let FullView = segue.destination as? FullImageViewController {
            print(viewModel.CelebrityImages[SelectedImageIndex.row])
            FullView.image = viewModel.CelebrityImages[SelectedImageIndex.row]
            }
        }
    }
    
   func initFetchDetails(){
    ////
    viewModel.updateLoadingStatus = { [weak self] () in
        guard let self = self else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            switch self.viewModel.state {
            case .error:
                    self.ActivityIndicator.stopAnimating()
                    self.ActivityIndicator.isHidden = true
                    self.showAlert("Network Error")
                    UIView.animate(withDuration: 0.2, animations: {
                        })
            case .initalize:
                self.ActivityIndicator.startAnimating()
                UIView.animate(withDuration: 0.2, animations: {
                })
            case .populated:
                self.celebrityDetails = self.viewModel.FullDetailedCelebrity
                self.ActivityIndicator.stopAnimating()
                self.ActivityIndicator.isHidden = true
                UIView.animate(withDuration: 0.2, animations: {
                    self.ShowViews()
                })
            case .ReadyForImages:
                self.CollectionView.isHidden = false
                self.CollectionView.reloadData()
            }
          }
        }
    
    viewModel.ReloadCollectionView = { [weak self] () in
        DispatchQueue.main.async {
            self?.CollectionView.reloadData()
        }
    }
    self.viewModel.initFillDetailsRequest()
    self.viewModel.GetCelebrityImages(Id: PassedCelebrityId)
    }
    
    
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
