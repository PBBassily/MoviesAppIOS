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
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if usageType == .movieCreation {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        }
        title = usageType.rawValue
    }
    
    @objc private func save() {
        
    }
    
}

extension MovieCreationAndDetailsViewController {
    internal enum UsageType: String {
        case showingMovieDetails = "Movie details"
        case movieCreation = "Create your movie"
    }
}
