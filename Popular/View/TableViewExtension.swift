//
//  TableViewExtension.swift
//  Popular
//
//  Created by Sherif Darwish on 3/8/20.
//  Copyright © 2020 TheAmrAli. All rights reserved.
//

import UIKit


extension Home: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CelebriCell", for: indexPath) as? CelebrityTableViewCellViewModel else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.celebrityViewModel = cellVM
        print("\(cellVM.Name)")
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfCells - 1
        {
            
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            customView.backgroundColor = UIColor.clear
            let activityIndicator  = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.color = .darkGray
            activityIndicator.startAnimating()
            customView.addSubview(activityIndicator)
            activityIndicator.center = customView.center
            tableView.tableFooterView = customView
            
            
            let lastindexpath = IndexPath(item: (indexPath.row) , section: 0)
            tableView.scrollToRow(at: lastindexpath , at: .none, animated: false)
           
            viewModel.Page += 1
            if self.SearchBar.text == "" {
            viewModel.initFetch()
                print("next for fetch")
            }else{
                let lastindexpath = IndexPath(item: (indexPath.row) , section: 0)
                tableView.scrollToRow(at: lastindexpath , at: .none, animated: false)
                
                print("nextforSearch")
                var TextToSearch = SearchBar.text
                if SearchBar.text?.contains(" ") ?? true {
                    TextToSearch = SearchBar.text?.replacingOccurrences(of: " ", with: "%20")
                }
                viewModel.initSearch(query: TextToSearch ?? "")
            }
            //self.LastIndexpathForCell = indexPath
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
}
