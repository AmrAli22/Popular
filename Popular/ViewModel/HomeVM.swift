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

class HomeViewModel {
    
    let apiService: APIServiceProtocol
    
    private var Celebrities: [CelebrityCell] = [CelebrityCell]()
    
    private var cellViewModels: [CelebrityCellViewModel] = [CelebrityCellViewModel]() {
        didSet {
            print("pop")
            self.populted?()
        }
    }
    
    // callback for interfaces
    var state: State = .initalize {
        didSet {
            self.updateLoadingStatus?()

        }
    }
    
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
        state = .initalize
        apiService.fetchPopularCelebritries { [weak self] (success, celebrities, error) in
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
            print("state is populated")
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> CelebrityCellViewModel {
        print("called")
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( Celebrity : CelebrityCell ) -> CelebrityCellViewModel {
        
        return CelebrityCellViewModel(
              Name: Celebrity.name
            , KnownAs: Celebrity.knownFor.first!.originalName ?? ""
            , Bd: Celebrity.name
            , Bio: Celebrity.profilePath ?? "")
    }
    
    private func processFetchedCelebrities( celebrities : [CelebrityCell] ) {
        var vmc = [CelebrityCellViewModel]()
        for celebri in celebrities {
            vmc.append( createCellViewModel(Celebrity: celebri) )
            print(vmc)
        }
        self.cellViewModels = vmc
    }
}

