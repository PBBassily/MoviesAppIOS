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
    private var hasPersonalMovies: Bool {
        return !(moviesDictionary[.myMovies]?.isEmpty ?? true)
    }
    internal var updateMoviesList: (() -> Void)?
    
    internal init() {
        moviesDictionary = [SectionType: [Movie]]()
        model = MoviesListModel()
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
        model.getMovies { [weak self] error, movies in
            self?.moviesDictionary[.allMovies] = movies
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
