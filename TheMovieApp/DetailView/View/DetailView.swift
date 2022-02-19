//
//  DetailView.swift
//  TheMovieApp
//
//  Created by juanki on 2/18/22.
//

import UIKit
import RxSwift

class DetailView: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionMovie: UILabel!
    @IBOutlet private weak var qualificationMovie: UILabel!
    @IBOutlet private weak var imageFilm: UIImageView!
    @IBOutlet private weak var releaseMovie: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    
    var movieID: String?
    private var router = DetailRouter()
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataAndShowDetailMovie()
        viewModel.bind(view: self, router: router)
    }
    
    private func getDataAndShowDetailMovie() {
        guard let idMovie = movieID else { return }
        return viewModel.getMoviedata(movieID: idMovie)
            .subscribe(
                onNext: { movie in
                    self.showMovieData(movie: movie)
                },
                onError: { error in
                    print("Ha ocurrido un error:\(error)")
                },
                onCompleted: {
                }).disposed(by: disposeBag)
    }
    
    
    
    func showMovieData(movie: MovieDetail) {
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            self.imageFilm.uploadFromServer(urlString: Constants.URL.urlImages+movie.posterPath, placeHolderImage: UIImage(named: "cinta cine")!)
            self.descriptionMovie.text = movie.overview
            self.releaseMovie.text = movie.releaseDate
            self.originalTitle.text =  movie.originaltitle
            self.qualificationMovie.text = String(movie.voteAverage)
            
        }
    }
    
}
