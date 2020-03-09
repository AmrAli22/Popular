//
//  File.swift
//  Popular
//
//  Created by Sherif Darwish on 3/7/20.
//  Copyright © 2020 TheAmrAli. All rights reserved.
//

import Foundation
let ApiKey = "eae3a2fa2839b7e941a64bbc8c1074c7"
let PersonDetails = "https://api.themoviedb.org/3/person/{person_id}?api_key=\(ApiKey)&language=en-US"

func FetchPersonDetails (PersonId : Int) -> String {
    return "https://api.themoviedb.org/3/person/\(PersonId)?api_key=\(ApiKey)&language=en-US"
}
func FetchPopular (page : Int) -> URL? {
    return URL.init(string: "https://api.themoviedb.org/3/person/popular?api_key=\(ApiKey)&language=en-US&page=\(page)")
}

func FetchPersonImages (PersonId : Int) -> String {
    return "https://api.themoviedb.org/3/person/\(PersonId)/images?api_key=\(ApiKey)"
}

func FetchSearchedPerson (query : String) -> URL? {
return URL.init(string: "https://api.themoviedb.org/3/search/person?api_key=\(ApiKey)&language=en-US&page=1&query=\(query)")

}

func FetchFullPerson (id : Int) -> URL? {
    return URL.init(string: "https://api.themoviedb.org/3/person/\(id)?api_key=\(ApiKey)&language=en-US")
}
func GetImagesUrls (id : Int) -> URL?{
    return URL.init(string: "https://api.themoviedb.org/3/person/\(id)/images?api_key=\(ApiKey)")
}


