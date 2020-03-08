
//
//  APIService.swift
//  MVVMPlayground

import Foundation
import Alamofire

enum APIError: String, Error {
    case noNetwork = "No Network"
}

protocol APIServiceProtocol {
    func fetchPopularCelebritries(  pageNum : Int ,complete: @escaping ( _ success: Bool, _ Celebrities: [CelebrityCell], _ error: APIError? )->() )
    func fetchSearchedCelebritries(  pageNum : Int , query : String ,complete: @escaping ( _ success: Bool, _ Celebrities: [CelebrityCell], _ error: APIError? , _ TotalPages: Int )->() )
}

class APIService: APIServiceProtocol {
    func fetchSearchedCelebritries(pageNum: Int, query: String, complete: @escaping (Bool, [CelebrityCell], APIError? , Int) -> ()) {
    
        Alamofire.request(FetchSearchedPerson(query: query)!, method: .get, parameters: nil).responseJSON { (response) in
            
            switch response.result{
            case .success(_):
                print("inSearchAPICall")
                do{
               
                    let data = try JSONDecoder().decode(Result.self, from: response.data!)
                    let totalPages = data.totalPages
                    let Celebrities = data.results
                    //print("SearhedCelbe = \(Celebrities)")
                    for new in Celebrities {
                        print("incall \(new.name)")
                    }
                    complete(true, Celebrities , nil, totalPages)
                    
                }catch{
                    complete(false,[],APIError.noNetwork, 0)
                    print(error)
                }
                
            case .failure(_):
                complete(false,[],APIError.noNetwork, 0)
            }
        }
        
    }
    
    
    func fetchPopularCelebritries( pageNum : Int ,complete: @escaping ( _ success: Bool, _ Celebrities : [CelebrityCell], _ error: APIError?)->()) {
        Alamofire.request(FetchPopular(page: pageNum )!, method: .get, parameters: nil).responseJSON { (response) in
            
            switch response.result{
            case .success(_):
                
                do{
                    let data = try JSONDecoder().decode(Result.self, from: response.data!)
                    let Celebrities = data.results
                    complete(true, Celebrities , nil)
                    
                }catch{
                    complete(false,[],APIError.noNetwork)
                    print(error)
                }
                
            case .failure(_):
                complete(false,[],APIError.noNetwork)
            }
        }
}
}

