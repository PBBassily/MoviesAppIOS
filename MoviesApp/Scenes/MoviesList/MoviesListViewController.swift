//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/14/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import UIKit

internal class MoviesListViewController: UIViewController {
    
    @IBOutlet private weak var moviesTableView: UITableView!
    private var viewModel: MoviesListViewModel!
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        configureTableView()
        handleUpadateMoviesAction()
        registerMovieTableViewCell()
    }
    
    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestMovies()
    }
    
    private func initViewModel() {
        viewModel = MoviesListViewModel()
    }
    
    private func configureTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
    
    private func handleUpadateMoviesAction() {
        viewModel.updateMoviesList = {
            DispatchQueue.main.async { [weak self] in
                self?.moviesTableView.reloadData()
            }
        }
    }
    
    private func registerMovieTableViewCell() {
        let nib = UINib(nibName: AppNibFiles.MovieTableViewCell.rawValue, bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.resubaleIdentifier)
    }
}

extension MoviesListViewController: UITableViewDataSource {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionType = MoviesListViewModel.SectionType(rawValue: section) else {
            return ""
        }
        return viewModel.getSectionTitle(at: sectionType)
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = MoviesListViewModel.SectionType(rawValue: section) else {
            return 0
        }
        return viewModel.getNumberOfMovies(at: sectionType)
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.resubaleIdentifier) as? MovieTableViewCell, let movie = viewModel.getMovie(at: indexPath) {
            cell.configure(with: movie)
            if movie.hasPoster {
                cell.setMoviePoster(movie.poster ?? UIImage())
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension MoviesListViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstants.MOVIE_TABLEVIEW_CELL_HEIGHT
    }
    
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == MoviesListViewModel.SectionType.allMovies.rawValue, indexPath.row == viewModel.lastMovieIndex, viewModel.hasMorePages {
            viewModel.requestMovies()
            
        }
    }
}

