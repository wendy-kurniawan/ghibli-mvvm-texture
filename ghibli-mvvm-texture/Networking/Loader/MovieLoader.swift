//
//  MovieLoader.swift
//  ghibli-mvvm-texture
//
//  Created by wendy.kurniawan on 21/11/22.
//

import RxSwift

internal protocol MovieLoader {
    func request() -> Observable<[Movie]>
}
