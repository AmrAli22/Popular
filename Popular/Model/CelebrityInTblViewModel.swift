// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let CelebrityCell = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct Result: Codable {
    
    let page, totalResults, totalPages: Int
    let results: [CelebrityCell]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct CelebrityCell: Codable {
    let popularity: Double
    let knownForDepartment: KnownForDepartment
    let name: String
    let id: Int
    let profilePath: String?
    let adult: Bool
    let knownFor: [KnownFor]
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case knownForDepartment = "known_for_department"
        case name, id
        case profilePath = "profile_path"
        case adult
        case knownFor = "known_for"
        case gender
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let originalName: String?
    let genreIDS: [Int]
    let mediaType: MediaType
    let name: String?
    let originCountry: [String]?
    let voteCount: Int
    let firstAirDate: String?
    let backdropPath: String?
    let originalLanguage: String
    let id: Int
    let voteAverage: Double
    let overview: String
    let posterPath: String?
    let video, adult: Bool?
    let originalTitle, title, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case mediaType = "media_type"
        case name
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
        case video, adult
        case originalTitle = "original_title"
        case title
        case releaseDate = "release_date"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
    case directing = "Directing"
}



