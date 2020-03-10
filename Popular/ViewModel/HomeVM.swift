//
//  HomeVM.swift
//  Popular
//
//  Created by Sherif Darwish on 3/7/20.
//  Copyright © 2020 TheAmrAli. All rights reserd

//
//  PhotoListViewModel.swift
//  MVVMPlayground
//
import Foundation
import UIKit

class HomeViewModel {
    
    let apiService: APIServiceProtocol
    
    
    
 var cellViewModels: [CelebrityCellViewModel] = [CelebrityCellViewModel]() {
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
    
    var Page : Int = 1
    var TotalPages :Int = 2
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
        
    var initilize: (()->())?
    var populted: (()->())?
    var infinteScroll: (()->())?
    var RelodtableView: (()->())?
    var updateLoadingStatus: (()->())?
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        if Page == 1 {
            state = .initalize }
        apiService.fetchPopularCelebritries(pageNum: Page) { [weak self] (success, celebrities, error) in
            guard let self = self else {
                return
            }
            
            guard error == nil else {
                self.state = .error
                return
            }
            self.processFetchedCelebrities(celebrities: celebrities)
            self.state = .populated
            self.RelodtableView?()

        }
    }
    
    
    func initSearch(query : String){
        if Page > TotalPages{
            return
        }else{
        apiService.fetchSearchedCelebritries(pageNum: Page, query: query) { [weak self] (success, Searchedcelebriries, error , ReturnedTotalPages)  in
            self?.TotalPages = ReturnedTotalPages
            guard let self = self else {
                return
            }
            
            guard error == nil else {
                self.state = .error
                return
            }
            self.processSearchedFetchedCelebrities(SearchedCelebrities: Searchedcelebriries)
            self.state = .populated
            self.RelodtableView?()

        }
    }
    }
    
    
    func getCellViewModel( at indexPath: IndexPath ) -> CelebrityCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( Celebrity : CelebrityCell ) -> CelebrityCellViewModel {
        
        return CelebrityCellViewModel(Name: Celebrity.name , KnownFor: Celebrity.knownForDepartment, id: Celebrity.id)
    }
    
    private func processSearchedFetchedCelebrities(SearchedCelebrities : [CelebrityCell]){
        print("in processSearchedFetchedCelebrities")
        if SearchedCelebrities.isEmpty {
          print("enoughSearching")
        }else{
        var vmc = [CelebrityCellViewModel]()
            
        for celebri in SearchedCelebrities {
            vmc.append( createCellViewModel(Celebrity: celebri) )
        }
        if self.Page == 1 {
            self.cellViewModels = vmc
        }else{
           self.cellViewModels.append(contentsOf: vmc)
        }
        }
    }
    
    
    private func processFetchedCelebrities( celebrities : [CelebrityCell] ) {
        var vmc = [CelebrityCellViewModel]()
        for celebri in celebrities {
            vmc.append(createCellViewModel(Celebrity: celebri) )
        }
        self.cellViewModels.append(contentsOf: vmc)
    }
    
}

