
//
//  APIService.swift
//  MVVMPlayground

import Foundation
import Alamofire

enum APIError: String, Error {
    case noNetwork = "No Network"
}

protocol APIServiceProtocol {
    func fetchPopularCelebritries(  pageNum : Int ,complete: @escaping ( _ success: Bool, _ photos: [CelebrityCell], _ error: APIError? )->() )
}

class APIService: APIServiceProtocol {
    func fetchPopularCelebritries( pageNum : Int ,complete: @escaping ( _ success: Bool, _ photos: [CelebrityCell], _ error: APIError?)->()) {
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

