//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Paula Boules on 6/14/19.
//  Copyright © 2019 Paula Boules. All rights reserved.
//

import UIKit

internal class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var posterView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var overviewTextField: UITextView!
    @IBOutlet private weak var posterLoadingIndicator: UIActivityIndicatorView!
    

    override internal func awakeFromNib() {
        super.awakeFromNib()
        configurePosterView()
    }
    
    private func configurePosterView() {
        posterView.layer.cornerRadius = 5
        posterView.contentMode = .scaleAspectFill
        posterView.clipsToBounds = true
    }
    
    private func configureDateLabel(with date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = formatter.string(from: date)
    }
    
    internal func configure(with movie: Movie) {
        configureDateLabel(with: movie.date)
        titleLabel.text = movie.title
        overviewTextField.text = movie.overview
        posterLoadingIndicator.startAnimating()
    }
    
    internal func setMoviePoster(_ image: UIImage) {
        posterLoadingIndicator.stopAnimating()
        posterView.image = image
    }

}
