//
//  DetailRouter.swift
//  TheMovieApp
//
//  Created by juanki on 2/18/22.
//

import UIKit

class DetailRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    var movieID: String?
    
    
    private var sourceView: UIViewController?
    
    init(movieID: String? = ""){
        self.movieID = movieID
    }
    
    private func createViewController() -> UIViewController {
        let view = DetailView(nibName: "DetailView", bundle: Bundle.main)
        view.movieID = self.movieID
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }
    
    
    
}
