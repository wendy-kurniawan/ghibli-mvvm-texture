//
//  MovieUseCase.swift
//  ghibli-mvvm-texture
//
//  Created by wendy.kurniawan on 21/11/22.
//

import RxSwift

internal protocol MovieUseCase {
    func fetchMovies() -> Observable<[Movie]>
}
