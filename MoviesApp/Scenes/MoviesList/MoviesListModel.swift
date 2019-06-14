//
//  MoviesListModel.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/14/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import Foundation
import UIKit

internal class MoviesListModel {
    
    internal func getMovies(at page: Int, completionHandler: @escaping (Error?, [Movie]) -> Void) {
        var error: NSError?
        var movies = [Movie]()
        DispatchQueue.global(qos: .utility).async { [weak self] in
            APIClient.shared.getMovies(at: page) { response, data in
                guard let self = self else {
                    return
                }
                if let statusCode = response?.statusCode, let data = data {
                    switch statusCode {
                    case 200:
                        do {
                            let repsonseDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                            if let moviesRawData  = repsonseDictionary?["results"] as? [[String: Any]] {
                                for movieRawData in moviesRawData {
                                    if let movie = self.parseData(movieRawData) {
                                        movies.append(movie)
                                    }
                                }
                            }
                        } catch {
                            completionHandler(NSError(domain: "", code: 0, userInfo: ["message": "can not parse data"]), movies)
                            return
                        }
                    default:
                        error = NSError(domain: "", code: statusCode, userInfo: ["message": "bad response"])
                    }
                } else {
                    error = NSError(domain: "", code: 0, userInfo: ["message": "no response"])
                }
                completionHandler(error, movies)
            }
        }
    }
    
    private func parseData(_ movieRawData: [String: Any]) -> Movie? {
        guard let id = movieRawData["id"] as? Int,
            let title = movieRawData["title"] as? String,
            let overview = movieRawData["overview"] as? String else {
                return nil
        }
        return Movie(id: id, title: title, overview: overview, dateRaw: movieRawData["release_date"] as? String, posterUrl: movieRawData["poster_path"] as? String)
    }
}
