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
    private let endPointUrl = URL(string: "http://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&page=1000")
    private let TIMEOUT_INTERVAL: TimeInterval = 10
    
    private init() {}
    
    internal func getMovies(at page: Int = 1, completionHandler: @escaping (HTTPURLResponse?, Data?) -> Void) {
        if let endPointUrl = endPointUrl {
            var request = URLRequest(url: endPointUrl)
            request.timeoutInterval = TIMEOUT_INTERVAL
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { (data, response, _) in
                completionHandler(response as? HTTPURLResponse, data)
            }
            task.resume()
        }
    }
}
