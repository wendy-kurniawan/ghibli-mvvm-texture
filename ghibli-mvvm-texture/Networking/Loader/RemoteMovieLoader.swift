//
//  RemoteMovieLoader.swift
//  ghibli-mvvm-texture
//
//  Created by wendy.kurniawan on 21/11/22.
//

import RxSwift

internal struct RemoteMovieLoader: MovieLoader {
    private let urlString: String
    private let urlSession: URLSession
    
    internal init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func request() -> Observable<[Movie]> {
        Observable.create { observer -> Disposable in
            guard let url = URL(string: urlString) else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            let task = urlSession.dataTask(with: URLRequest(url: url)) { data, response, error in
                if error != nil {
                    observer.onError(NetworkError.invalidRequest)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    observer.onError(NetworkError.invalidResponse)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NetworkError.invalidData)
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let movies = try? decoder.decode([Movie].self, from: data) else {
                    observer.onError(NetworkError.invalidData)
                    return
                }
                
                observer.onNext(movies)
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
