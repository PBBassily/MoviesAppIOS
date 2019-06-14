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
    }
    
    private func initViewModel() {
        viewModel = MoviesListViewModel()
    }
    
    private func configureTableView() {
        moviesTableView.dataSource = self
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
        return UITableViewCell()
    }
    
    
}

