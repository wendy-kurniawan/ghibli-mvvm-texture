//
//  MovieViewModelTests.swift
//  ghibli-mvvm-textureTests
//
//  Created by wendy.kurniawan on 21/11/22.
//

import XCTest
import RxSwift
import RxCocoa
@testable import ghibli_mvvm_texture

internal final class MovieViewModelTests: XCTestCase {
    
    internal func test_init_shouldNotFetchMovie() {
        let useCase = MovieUseCaseSpy()
        _ = MovieViewModel(useCase: useCase)
        
        XCTAssertEqual(useCase.fetchMoviesCallCount, 0)
    }
    
    internal func test_fetchMovies_withOneCall_shouldFetchMoviesOnce() {
        let useCase = MovieUseCaseSpy()
        let sut = MovieViewModel(useCase: useCase)
        let disposeBag = DisposeBag()
        let expectation = expectation(description: "fetchMovies Completed")
        
        let input = MovieViewModel.Input(
            didLoad: Driver.just(())
        )
        
        let output = sut.transform(input: input)
        output.showMovies.drive(onNext: { _ in
            expectation.fulfill()
        })
        .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 0.5)
        XCTAssertEqual(useCase.fetchMoviesCallCount, 1)
    }
    
    internal func test_fetchMovies_withTwoCalls_shouldFetchMoviesTwice() {
        let useCase = MovieUseCaseSpy()
        let sut = MovieViewModel(useCase: useCase)
        let disposeBag = DisposeBag()
        let fetchExpectation = XCTestExpectation(description: "fetchMovies Completed")
        let secondFetchExpectation = XCTestExpectation(description: "secondFetchMovies Completed")
        
        let input = MovieViewModel.Input(
            didLoad: Driver.just(())
        )
        
        var output = sut.transform(input: input)
        output.showMovies.drive(onNext: { _ in
            fetchExpectation.fulfill()
        })
        .disposed(by: disposeBag)
        
        output = sut.transform(input: input)
        output.showMovies.drive(onNext: { _ in
            secondFetchExpectation.fulfill()
        })
        .disposed(by: disposeBag)
        
        wait(for: [fetchExpectation, secondFetchExpectation], timeout: 0.5)
        XCTAssertEqual(useCase.fetchMoviesCallCount, 2)
    }
    
    internal func test_fetchMovies_withSuccessNetwork_shouldReturnItems() {
        let useCase = SuccessMovieUseCaseStub()
        let sut = MovieViewModel(useCase: useCase)
        let disposeBag = DisposeBag()
        var movies = [Movie]()
        let expectation = expectation(description: "Wait for movies result")
        
        let input = MovieViewModel.Input(
            didLoad: Driver.just(())
        )
        
        let output = sut.transform(input: input)
        output.showMovies.drive(onNext: {
            movies = $0
            expectation.fulfill()
        })
        .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(movies, FakeMovies.movies)
    }
    
    internal func test_fetchMovies_withFailureNetwork_shouldNotReturnItems() {
        let useCase = FailureMovieUseCaseStub()
        let sut = MovieViewModel(useCase: useCase)
        let disposeBag = DisposeBag()
        var movies = [Movie]()
        let expectation = expectation(description: "Wait for movies result")
        
        let input = MovieViewModel.Input(
            didLoad: Driver.just(())
        )
        
        let output = sut.transform(input: input)
        output.showMovies.drive(onNext: {
            movies = $0
            expectation.fulfill()
        })
        .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(movies, [])
    }
}
