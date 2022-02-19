//
//  ManagerConnections.swift
//  TheMovieApp
//
//  Created by juanki on 2/10/22.
//

import Foundation
import RxSwift

enum APIError: Error {
    case errorConnection(String)
}
class ManagerConnections {
    
    func getPopularMovies() -> Observable<[Movie]> {
            return Observable.create { observer in
                
                let session = URLSession.shared
                var request = URLRequest(url:URL(string:Constants.URL.main+Constants.Endpoints.urlListPopularMovies+"?api_key="+Constants.apiKey)!)
                request.httpMethod = "GET"
                request.addValue("application/json", forHTTPHeaderField:
                    "Content-Type")
                session.dataTask(with: request) { (data, response, error) in
                    guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                    print(response.statusCode)
                    if response.statusCode == 200 {
                        do {
                            let decoder = JSONDecoder()
                            let movies = try decoder.decode(Movies.self, from: data)
                            observer.onNext(movies.listOfmovies)
                        } catch {
                            //MARK: observer onNext event
                            print("entre aca sucedio un errror :(")
                            //observer.onError(APIError.errorConnection("Server code: \(response.statusCode)"))
                        }
                    }
                    //MARK: observer onCompleted event
                    observer.onCompleted()
                }.resume()
                //MARK: return our disposable
                return Disposables.create {
                    session.finishTasksAndInvalidate()
                }
            }
        }
    
    
    
    func getDetailMovies(movieID: String)-> Observable<MovieDetail> {
        return Observable.create { observer in
            
            let session = URLSession.shared
            var request = URLRequest(url:URL(string:Constants.URL.main+Constants.Endpoints.urlDetailMovie+movieID+"?api_key="+Constants.apiKey)!)
            print(URL(string:Constants.URL.main+Constants.Endpoints.urlDetailMovie+movieID+"?api_key="+Constants.apiKey))
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField:
                "Content-Type")
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let detailMovie = try decoder.decode(MovieDetail.self, from: data)
                        observer.onNext(detailMovie)
                    } catch {
                        //MARK: observer onNext event
                        print("entre aca sucedio un errror :(")
                        //observer.onError(APIError.errorConnection("Server code: \(response.statusCode)"))
                    }
                }
                //MARK: observer onCompleted event
                observer.onCompleted()
            }.resume()
            //MARK: return our disposable
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
}
