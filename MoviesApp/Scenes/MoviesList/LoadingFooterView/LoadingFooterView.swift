//
//  LoadingFooterView.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/15/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import UIKit

internal class LoadingFooterView: UITableViewHeaderFooterView {

    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    internal static var resubaleIdentifier: String {
        return "\(self)"
    }
    
    internal func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    internal func startLoading() {
        activityIndicator.startAnimating()
    }
    
}
