//
//  SearchBarExtension.swift
//  Popular
//
//  Created by Sherif Darwish on 3/8/20.
//  Copyright © 2020 TheAmrAli. All rights reserved.
//

import UIKit
extension Home : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.Page = 1
        print("textchanged")
        var TextToSearch = searchText
        if searchBar.text == "" {
            self.initVM()
        }else{
            if searchText.contains(" "){
                TextToSearch = searchText.replacingOccurrences(of: " ", with: "%20")
            }
        viewModel.initSearch(query: TextToSearch)
        }
    }
    
}
