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
    
    internal func getMovies(completionHandler: @escaping (Error?, [Movie]) -> Void) {
        var error: NSError?
        var movies = [Movie]()
        DispatchQueue.global(qos: .utility).async {
            for i in 1 ... 100 {
                let movie = Movie(title: "Movie #\(i)", overview: String(repeating: "overview ", count: i), date: Date(), posterUrl: nil, poster: UIImage(named: "poster_placeholder"))
                movies.append(movie)
            }
            completionHandler(error, movies)
        }
    }
}
