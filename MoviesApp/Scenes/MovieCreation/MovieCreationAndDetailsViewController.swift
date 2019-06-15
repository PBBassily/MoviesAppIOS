//
//  MovieCreationAndDetails.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/15/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import UIKit

internal class MovieCreationAndDetailsViewController: UIViewController {
    
    internal var usageType: UsageType = .movieCreation
    private var viewModel: MovieCreationViewModel!
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        initViewModel()
    }
    
    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if usageType == .movieCreation {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        }
        title = usageType.rawValue
    }
    
    private func configureView() {
        if let view = view as? MovieCreationAndDetailsView, usageType == .movieCreation {
            view.delegate = self
        }
    }
    
    private func initViewModel() {
        viewModel = MovieCreationViewModel()
    }
    
    private func showAlert(message: String) {
        let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Okay", style: .cancel))
        present(alertVC, animated: true)
    }
    
    @objc private func save() {
        view.endEditing(true)
        if viewModel.shouldSave {
            _ = viewModel.getMovie()
        } else {
            showAlert(message: viewModel.getFaliureReasonMessage())
        }
    }
    
}

extension MovieCreationAndDetailsViewController {
   
    internal enum UsageType: String {
        case showingMovieDetails = "Movie details"
        case movieCreation = "Create your movie"
    }
}

extension MovieCreationAndDetailsViewController: MovieCreationViewDelegate {
    
    internal func didChangePotser(_ poster: UIImage?) {
        viewModel.poster = poster
    }
    
    internal func didChangeDate(_ date: String) {
        viewModel.dateRawString = date
    }
    
    internal func didChangeTitle(_ title: String) {
        viewModel.title = title
    }
    
    internal func didChangeOverview(_ overview: String) {
        viewModel.overview = overview
    }
}
