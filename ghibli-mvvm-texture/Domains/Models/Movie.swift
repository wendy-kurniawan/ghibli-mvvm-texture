//
//  Movie.swift
//  ghibli-mvvm-texture
//
//  Created by wendy.kurniawan on 21/11/22.
//

import Foundation

internal struct Movie: Decodable, Equatable {
    internal let title: String
    internal let director: String
    internal let releaseDate: String
    internal let movieBanner: String
}
