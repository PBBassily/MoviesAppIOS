//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/14/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import Foundation

internal class MoviesListViewModel {
    
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
}

extension MoviesListViewModel {
    
    internal enum SectionType: Int, CaseIterable {
        case myMovies
        case allMovies
    }
}
