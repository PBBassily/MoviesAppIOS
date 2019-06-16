//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/14/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import Foundation
import UIKit

internal class MoviesListViewModel {
    
    private var MAXIMUMU_NUMBER_OF_IMAGES_TO_BE_CACHED = 100
    private var moviesDictionary: [SectionType: [Movie]]
    private var model: MoviesListModel
    private var currentPage: Int
    private var hasPersonalMovies: Bool {
        return !(moviesDictionary[.myMovies]?.isEmpty ?? true)
    }
    internal var updateMoviesList: (() -> Void)?
    internal var hasMorePages: Bool
    internal var lastMovieIndex: Int {
        return (moviesDictionary[.allMovies]?.count ?? 1) - 1
    }
    
    internal init() {
        moviesDictionary = [SectionType: [Movie]]()
        model = MoviesListModel()
        currentPage = 0
        hasMorePages = true
        initMoviesDataSource()
    }
    
    private func initMoviesDataSource() {
        moviesDictionary[.myMovies] = [Movie]()
        moviesDictionary[.allMovies] = [Movie]()
    }
    
    internal func getNumberOfSections() -> Int {
        return SectionType.allCases.count
    }
    
    internal func getSectionTitle(at sectionType: SectionType) -> String {
        switch sectionType {
        case .myMovies where hasPersonalMovies:
            return "My Movies"
        case .allMovies:
            return "All Movies"
        default:
            return ""
        }
    }
    
    internal func getNumberOfMovies(at sectionType: SectionType) -> Int {
        return moviesDictionary[sectionType]?.count ?? 0
    }
    
    internal func getMovie(at indexPath: IndexPath) -> Movie? {
        guard let sectionType = SectionType(rawValue: indexPath.section),
            let moviesList = moviesDictionary[sectionType],
            indexPath.row < moviesList.count else {
                return nil
        }
        return moviesList[indexPath.row]
    }
    
    internal func requestMovies() {
        currentPage += 1
        model.getMovies(at: currentPage) { [weak self] error, movies in
            if error == nil {
                self?.moviesDictionary[.allMovies]?.append(contentsOf: movies)
            } else if let error = error as NSError?, error.code == 422 {
                self?.hasMorePages = false
            } else {
                // TODO
            }
            self?.updateMoviesList?()
        }
    }
    
    internal func downloadPosterForMovie(at indexPath: IndexPath, width: Int, completionHandler: @escaping (UIImage?, Int?) -> Void) {
        guard let sectionType = SectionType(rawValue: indexPath.section),
            let moviesList = moviesDictionary[sectionType],
            indexPath.row < moviesList.count else {
                completionHandler(nil, nil)
                return
        }
        model.downloadImage(for: moviesList[indexPath.row], width: width) { [weak self] image in
            guard let self = self else {
                return
            }
            self.moviesDictionary[sectionType]?[indexPath.row].poster = image // caching images
            let previouslyCachedPosterIndex  = indexPath.row - self.MAXIMUMU_NUMBER_OF_IMAGES_TO_BE_CACHED
            if  previouslyCachedPosterIndex >= 0 {
                self.moviesDictionary[sectionType]?[previouslyCachedPosterIndex].poster = nil // maintin the maximum number of cached images
            }
            completionHandler(image, moviesList[indexPath.row].id)
        }
    }
    
    internal func addUserPersonalMovie(_ movie: Movie) {
        self.moviesDictionary[.myMovies]?.append(movie)
    }
}

extension MoviesListViewModel {
    
    internal enum SectionType: Int, CaseIterable {
        case myMovies
        case allMovies
    }
}
