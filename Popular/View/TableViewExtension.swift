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
        print("cell created")
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
}
