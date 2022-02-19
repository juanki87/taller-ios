//
//  HomeViewModel.swift
//  TheMovieApp
//
//  Created by juanki on 2/2/22.
//

import Foundation
import RxSwift

class HomeViewModel {
    private weak var view: HomeView?
    private var router: HomeRouter?
    private var managerConexion = ManagerConnections()
    private let disposeBag = DisposeBag()
    
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
       self.router?.setSourceView(view)
    }
    
    func getListMoviesData() -> Observable<[Movie]> {
        return managerConexion.getPopularMovies()
    }
    
    func makeDetailView(movieID: String) {
        self.router?.navigateToDetailView(MovieID: movieID)
    }
    
}
