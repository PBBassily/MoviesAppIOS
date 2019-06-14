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
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        moviesTableView.dataSource = self
    }
}

extension MoviesListViewController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

