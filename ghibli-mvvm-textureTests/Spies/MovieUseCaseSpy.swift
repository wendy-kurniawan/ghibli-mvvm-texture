//
//  MovieUseCaseSpy.swift
//  ghibli-mvvm-textureTests
//
//  Created by wendy.kurniawan on 22/11/22.
//

import RxSwift
@testable import ghibli_mvvm_texture

internal class MovieUseCaseSpy: MovieUseCase {
    
    private(set) var fetchMoviesCallCount = 0
    
    func fetchMovies() -> Observable<[Movie]> {
        fetchMoviesCallCount += 1
        return Observable.just([])
    }
}
