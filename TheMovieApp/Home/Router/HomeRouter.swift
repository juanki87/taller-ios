//
//  HomeRouter.swift
//  TheMovieApp
//
//  Created by juanki on 2/2/22.
//

import Foundation
import UIKit

class HomeRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }
    
    func navigateToDetailView(MovieID: String) {
        let datailView = DetailRouter(movieID: MovieID).viewController
        sourceView?.navigationController?.pushViewController(datailView, animated: true)
    }
    
   
}
