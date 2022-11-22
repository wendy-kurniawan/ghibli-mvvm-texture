//
//  MovieUseCaseStub.swift
//  ghibli-mvvm-textureTests
//
//  Created by wendy.kurniawan on 21/11/22.
//

import RxSwift
import RxCocoa
@testable import ghibli_mvvm_texture

internal struct SuccessMovieUseCaseStub: MovieUseCase {
    func fetchMovies() -> Observable<[Movie]> {
        return Observable.just(FakeMovies.movies)
    }
}

internal struct FailureMovieUseCaseStub: MovieUseCase {
    func fetchMovies() -> Observable<[Movie]> {
        return Observable.just([])
    }
}
