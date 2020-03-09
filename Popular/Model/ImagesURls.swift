//
//  ImagesURls.swift
//  Popular
//
//  Created by Sherif Darwish on 3/9/20.
//  Copyright © 2020 TheAmrAli. All rights reserved.
//

import Foundation

// MARK: - ImagesUrls
struct ImagesUrls: Codable {
    let profiles: [Profile]
    let id: Int
}

// MARK: - Profile
struct Profile: Codable {
    let iso639_1: String?
    let width, height, voteCount: Int
    let voteAverage: Double
    let filePath: String
    let aspectRatio: Double
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case width, height
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case filePath = "file_path"
        case aspectRatio = "aspect_ratio"
    }
}
