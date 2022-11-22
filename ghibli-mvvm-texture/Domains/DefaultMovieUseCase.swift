//
//  DefaultMovieUseCase.swift
//  ghibli-mvvm-texture
//
//  Created by wendy.kurniawan on 21/11/22.
//

import RxSwift

internal struct DefaultMovieUseCase: MovieUseCase {
    
    private let loader: MovieLoader
    
    internal init(loader: MovieLoader) {
        self.loader = loader
    }
    
    internal func fetchMovies() -> Observable<[Movie]> {
        return loader.request()
    }
}

internal struct MovieUseCaseSuccessStub: MovieUseCase {
    func fetchMovies() -> Observable<[Movie]> {
        return Observable.just([])
    }
}
