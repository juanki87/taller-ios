//
//  HomeView.swift
//  TheMovieApp
//
//  Created by juanki on 2/2/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .black
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Search Movie"
        return controller
        
    })()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "The bests movies"
        configureTableView()
        getData()
        manageSearchBarController()
        viewModel.bind(view: self, router: router)
   
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomMovieCell")
    }
    
    private func getData() {
        return viewModel.getListMoviesData()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { movies in
                    self.movies = movies
                    self.reloadTableView()
            },
                onError: { error in
                    print(error.localizedDescription)
            },
                onCompleted: {
            }).disposed(by: disposeBag)
    }

        // take for granted RxSwift secuency
        
    
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    private func manageSearchBarController() {
        let searchBar = searchController.searchBar
        searchController.delegate  = self
        self.tableView.tableHeaderView = searchBar
        self.tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: {(result) in
                self.filteredMovies = self.movies.filter({ movie in
                    self.reloadTableView()
                    return movie.title.contains(result)
                    
                })
                
                
            }).disposed(by: disposeBag)
        }
}



extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return self.filteredMovies.count
        }
        else {
            return self.movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieCell") as! MovieTableViewCell
        if searchController.isActive && searchController.searchBar.text != "" {
        cell.imageMovie.uploadFromServer(urlString: "\(Constants.URL.urlImages+self.filteredMovies[indexPath.row].image)", placeHolderImage: UIImage(named: "cinta cine")!)
        cell.titleMovieLabel.text = self.filteredMovies[indexPath.row].title
        cell.descriptionMovieLabel.text = self.filteredMovies[indexPath.row].sinopsis
        
        } else {
            cell.imageMovie.uploadFromServer(urlString: "\(Constants.URL.urlImages+self.movies[indexPath.row].image)", placeHolderImage: UIImage(named: "cinta cine")!)
            cell.titleMovieLabel.text = self.movies[indexPath.row].title
            cell.descriptionMovieLabel.text = self.movies[indexPath.row].sinopsis
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 208
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            self.viewModel.makeDetailView(movieID: String(self.filteredMovies[indexPath.row].movieID))
        }
        else {
            self.viewModel.makeDetailView(movieID: String(self.movies[indexPath.row].movieID))
        }
    }
    
}

extension HomeView: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableView()
    }
}
