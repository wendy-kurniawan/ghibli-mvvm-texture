//
//  MovieViewModel.swift
//  ghibli-mvvm-texture
//
//  Created by wendy.kurniawan on 21/11/22.
//

import RxCocoa

internal class MovieViewModel: ViewModelType {
    
    private let useCase: MovieUseCase
    
    internal init(useCase: MovieUseCase) {
        self.useCase = useCase
    }
    
    internal struct Input {
        internal let didLoad: Driver<Void>
    }
    
    internal struct Output {
        internal let showMovies: Driver<[Movie]>
    }
    
    internal func transform(input: Input) -> Output {
        let movies = input.didLoad
            .flatMapLatest {
                self.useCase
                    .fetchMovies()
                    .asDriver { _ in .empty() }
            }
        
        return Output(
            showMovies: movies
        )
    }
}
