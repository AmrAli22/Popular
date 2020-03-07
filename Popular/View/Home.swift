//
//  ViewController.swift
//  Popular
//
//  Created by Sherif Darwish on 3/7/20.
//  Copyright © 2020 TheAmrAli. All rights reserved.
//

import UIKit

class Home: UIViewController {

    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // Init the static view
        initView()
        
        // init view model
        initVM()
        
    }
   
        lazy var viewModel: HomeViewModel = {
            return HomeViewModel()
        }()
    
   
    
        
        func initView() {
            
            let nib = UINib(nibName: "CelebrityTableViewCell", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: "CelebriCell")
            
            self.navigationItem.title = "Popular"
            
            tableView.estimatedRowHeight = 150
            tableView.rowHeight = UITableView.automaticDimension
        }
        
        func initVM() {
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
                        UIView.animate(withDuration: 0.2, animations: {
                            self.tableView.alpha = 0.0
                            print("error")
                        })
                    case .initalize:
                        self.ActivityIndicator.startAnimating()
                        UIView.animate(withDuration: 0.2, animations: {
                            self.tableView.alpha = 0.0
                            print("intilize")
                        })
                    case .populated:
                        self.ActivityIndicator.stopAnimating()
                        UIView.animate(withDuration: 0.2, animations: {
                            self.tableView.alpha = 1.0
                            print("pop")
                        })
                        
                        
                    case .infinteScroll: break
                        //infintescrollCode
                        print("code")
                    }
                }
            }
            
            viewModel.RelodtableView = { [weak self] () in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
            viewModel.initFetch()
            
        }
        
        func showAlert( _ message: String ) {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
    }
    



