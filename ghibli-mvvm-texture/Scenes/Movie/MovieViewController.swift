//
//  MovieViewController.swift
//  ghibli-mvvm-texture
//
//  Created by wendy.kurniawan on 21/11/22.
//

import AsyncDisplayKit
import RxSwift
import RxCocoa

internal final class MovieViewController: ASDKViewController<ASTableNode> {
    
    private var viewModel: MovieViewModel!
    private let disposeBag = DisposeBag()
    
    private var movies: [Movie] = []
    
    internal override init() {
        viewModel = MovieViewModel(
            useCase: DefaultMovieUseCase(
                loader: RemoteMovieLoader(
                    urlString: MovieRoutes.allMovies.rawValue
                )
            )
        )
        super.init(node: ASTableNode())
        
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        node.dataSource = self
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        node.view.separatorStyle = .none
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Studio Ghibli"
    }
    
    private func bindViewModel() {
        let input = MovieViewModel.Input(
            didLoad: Driver.just(())
        )
        
        let output = viewModel.transform(input: input)
        
        output.showMovies.drive(onNext: { [weak self] movies in
            guard let self = self else { return }
            self.movies = movies
            DispatchQueue.main.async {
                self.node.reloadData()
            }
        })
        .disposed(by: disposeBag)
    }

    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieViewController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let movie = movies[indexPath.row]
        return MovieCellNode(movie: movie)
    }
}
