//
//  DetailViewModel.swift
//  TheMovieApp
//
//  Created by juanki on 2/18/22.
//

import Foundation
import RxSwift

class DetailViewModel {
    private var managerConexion = ManagerConnections()
    private weak var view: DetailView?
    private var router: DetailRouter?
    
    func bind(view: DetailView, router: DetailRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getMoviedata(movieID: String)-> Observable<MovieDetail> {
        return managerConexion.getDetailMovies(movieID: movieID)
        
    }
    
}
