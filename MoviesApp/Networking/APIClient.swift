//
//  APIClient.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/14/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import Foundation

internal class APIClient {
    
    internal static let shared = APIClient()
    private let moviesEndPointRawUrl = "http://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2"
    private let postersEndPointRawUrl = "http://image.tmdb.org/t/p"
    private let TIMEOUT_INTERVAL: TimeInterval = 10
    
    private init() {}
    
    internal func getMovies(at page: Int = 1, completionHandler: @escaping (HTTPURLResponse?, Data?) -> Void) {
        if let endPointUrl = URL(string: "\(moviesEndPointRawUrl)&page=\(page)") {
            var request = URLRequest(url: endPointUrl)
            request.timeoutInterval = TIMEOUT_INTERVAL
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { (data, response, _) in
                completionHandler(response as? HTTPURLResponse, data)
            }
            task.resume()
        }
    }
    
    internal func dowloadFromServer(posterPath: String, width: Int ,completionHandler: @escaping(Data?) -> Void) {
        if let url = URL(string: "\(postersEndPointRawUrl)/w\(width)\(posterPath)") {
            var request = URLRequest(url: url)
            request.timeoutInterval = TIMEOUT_INTERVAL
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, _, _ in
                completionHandler(data)
            }
            task.resume()
        }
    }
}
