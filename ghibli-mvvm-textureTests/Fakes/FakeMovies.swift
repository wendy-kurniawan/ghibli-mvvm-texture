//
//  FakeMovies.swift
//  ghibli-mvvm-textureTests
//
//  Created by wendy.kurniawan on 21/11/22.
//

@testable import ghibli_mvvm_texture

internal struct FakeMovies {
    internal static let movies = [
        Movie(
            title: "Movie 1",
            director: "Director 1",
            releaseDate: "1919",
            movieBanner: ""
        ),
        Movie(
            title: "Movie 2",
            director: "Director 2",
            releaseDate: "1920",
            movieBanner: ""
        )
    ]
}
