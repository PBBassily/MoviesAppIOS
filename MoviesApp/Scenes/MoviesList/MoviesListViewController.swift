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
        registerNibFilesToTableView()
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
                if let loadingFooter = self?.moviesTableView.footerView(forSection: MoviesListViewModel.SectionType.allMovies.rawValue) as? LoadingFooterView {
                    loadingFooter.stopLoading()
                }
                self?.moviesTableView.reloadData()
            }
        }
    }
    
    private func registerNibFilesToTableView() {
        let moviesCellNib = UINib(nibName: AppNibFiles.MovieTableViewCell.rawValue, bundle: nil)
        moviesTableView.register(moviesCellNib, forCellReuseIdentifier: MovieTableViewCell.resubaleIdentifier)
        let footerNib = UINib(nibName: AppNibFiles.LoadingFooterView.rawValue, bundle: nil)
        moviesTableView.register(footerNib, forHeaderFooterViewReuseIdentifier: LoadingFooterView.resubaleIdentifier)
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
            if let loadingFooter = tableView.footerView(forSection: indexPath.section) as? LoadingFooterView {
                loadingFooter.startLoading()
            }
            
        }
    }
    
    internal func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let section = MoviesListViewModel.SectionType(rawValue: section), section == .allMovies {
            let footerView: LoadingFooterView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: LoadingFooterView.resubaleIdentifier) as? LoadingFooterView
            return footerView
        }
        return nil
    }
}

