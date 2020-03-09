
//
//  APIService.swift
//  MVVMPlayground

import Foundation
import Alamofire
import SDWebImage

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

protocol APIServiceFullDetailsProtocol {
    func fetchFullDetailsCelebritry( Id : Int ,complete: @escaping ( _ success: Bool, _ Celebrity: FullCelebrity?, _ error: APIError? )->() )
    
    func fetchCelebritryImagesUrls( Id : Int ,complete: @escaping ( _ success: Bool, _ Urls: [URL]?, _ error: APIError? )->() )

     func fetchCelebritryImages( Url : URL ,complete: @escaping ( _ success: Bool, _ image: UIImage?, _ error: APIError? )->() )
    
}

class ApiFullDetails: APIServiceFullDetailsProtocol {
 
    
    
    func fetchCelebritryImagesUrls(Id: Int, complete: @escaping (Bool, [URL]?, APIError?) -> ()) {
        Alamofire.request(GetImagesUrls(id: Id)!, method: .get, parameters: nil).responseJSON { (response) in
           
            switch response.result{
            case .success(_):
                
                do{
                    let data = try JSONDecoder().decode(ImagesUrls.self, from: response.data!)
                    let Profiles = data.profiles
                    var Urls : [URL] = []
                    for NewProfile in Profiles {
                        Urls.append(URL.init(string: "http://image.tmdb.org/t/p/original//\(NewProfile.filePath)")! )
                    }
                    complete(true, Urls , nil)
                }catch{
                    complete(false,nil,APIError.noNetwork)
                    print(error)
                }
                
            case .failure(_):
                complete(false,nil,APIError.noNetwork)
            }
        }
    }
    
    func fetchFullDetailsCelebritry(Id: Int, complete: @escaping (Bool, FullCelebrity?, APIError?) -> ()) {
        Alamofire.request(FetchPersonDetails(PersonId: Id), method: .get, parameters: nil).responseJSON { (response) in
          
            switch response.result{
            case .success(_):
                
                do{
                    let data = try JSONDecoder().decode(FullCelebrity.self, from: response.data!)
                 complete(true, data , nil)
                }catch{
                    complete(false,nil,APIError.noNetwork)
                    print(error)
                }
                
            case .failure(_):
                complete(false,nil,APIError.noNetwork)
            }
        }
    }
    
    
    
    
    func fetchCelebritryImages( Url : URL ,complete: @escaping ( _ success: Bool, _ image: UIImage?, _ error: APIError? )->() ){
        SDWebImageManager.shared.loadImage(
            with: Url,
            options: .highPriority,
            progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                if image != nil{
                    print("theimage = \(image)")
                    complete(true,image,nil)
                }else{
                    complete(false,nil,APIError.noNetwork)
                }
        }
    }
}
